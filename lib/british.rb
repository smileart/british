# encoding: utf-8

# Public: method_missing which tries to call "British" version before failing
# Could be included to the particular class or globally (monkey-patching Object)
#
# Examples
#
#   # Create classes with `initialise` constructor (British::Initialisable)
#   # And magic British methods and attributes (British)
#   class BritishObject
#     require 'british'
#
#     # use within your objects only *1 …
#     include British
#     include British::Initialisable
#
#     attr_reader :color
#
#     # works exactly like an initialize (including `super` usage)
#     def initialise(test)
#       @test = test
#       @color = 'red'
#
#       super('black', 'box', 'arguments')
#     end
#
#     def magnetize(test)
#       @test
#     end
#   end
#
#   british_object = BritishObject.new('Hello UK!')
#   british_object.test # => 'Hello UK!'
#
#   # Use British endings with any method or attribute
#   british_object.colour    # => "red"
#   british_object.magnetise # => "Hello UK!"
#
#   # *1 … patch third party or all the system Objects
#   String.include British
#   'cheers!'.capitalise # => "Cheers!"
#
#   require 'active_support/inflector'
#   include British
#
#   # Use is_an? with classes like an Array!
#   [].is_an? Array # => true
#
#   'cheers!'.capitalise # => "Cheers!"
#   'oi_ya_bloody_wanker'.camelise # => "OiYaBloodyWanker"
module British
  # Public: Hash of British ↔ American words endings
  ENDINGS = {
    # Latin-derived spellings
    'our'  => 'or',
    're'   => 'er',
    'ce'   => 'se',
    'xion' => 'ction',

    # Greek-derived spellings
    'ise'     => 'ize',
    'isation' => 'ization',
    'yse'     => 'yze',
    'ogue'    => 'og'
  }.freeze

  # Public: Regexp pattern to search/replace British words endings
  BRITISH_ENDING_PATTERN = /#{Regexp.union(ENDINGS.keys)}(?=_|-|\?|\!|=|$)/

  # Public: Submodule to be included in your own classes to use `initialise`
  #
  # As far as `initialize` called automatically by a `new` method there is no
  # sense to use it for third party classes.
  #
  module Initialisable
    # Public: On module being included do:
    #   1. Check if it's a global include
    #   2. Add and alias of the parent's `initialize` (for `super` calls)
    #   3. Create your own initialize method (to be auto-called by the `new`)
    #
    # Warning
    #   By including this module you redefine your initialiZe method.
    #   Use initialiSe method instead of the original, but not both!
    #
    # Example:
    #   include British::Initialisable
    #
    # Returns nothing
    def self.included(host_class)
      unless host_class == Object
        # alias parent's initialise method
        host_class.superclass.class_eval do
          alias_method :initialise, :initialize
        end

        # suppress 'method redefined; discarding old initialize' warning
        # https://goo.gl/PSzrbF ¯\_(ツ)_/¯
        verbose = $VERBOSE
        $VERBOSE = nil

        # Once again: since we use this Initialisable module in our classes
        # ONLY, and create our own initialiSe method, we can't break anything
        # by redefining initialiZe
        define_method :initialize do |*args|
          initialise(*args)
        end

        $VERBOSE = verbose
      end
    end
  end

  # Public: aliases for is_an?/is_a? methods
  alias is_an? is_a?
  alias an? is_an?

  # Hook to be called when British module being included
  # Add method_missing method with all the British 'magic' behaviour
  # Extends a class to make it British
  #
  # Example:
  #
  #   class Example
  #      include British
  #
  #      def color
  #         'red'
  #      end
  #   end
  #
  #   example = Example.new
  #   example.colour # => "red"
  #
  # Returns nothing
  def self.included(host_class)
    host_class.extend ClassMethods
    host_class.class_overwrite_method_missing

    host_class.instance_eval do
      def method_added(name)
        class_overwrite_method_missing if name == :method_missing
      end
    end
  end

  # Hook to be called when British module being used to extend an object
  # Add method_missing method with all the British 'magic' behaviour
  # Extends an object instance to make it British
  #
  # Example:
  #
  #   not_british = SomeClass.new # with color method
  #   refugee = SomeClass.new # with color method
  #
  #   # Make it British
  #   british = refugee.extend(British)
  #
  #   not_british.colour # undefined method `colour'
  #   british.colour # works well
  #
  # Returns nothing
  def self.extended(host_object)
    host_object.extend ClassMethods
    host_object.object_overwrite_method_missing

    host_object.instance_eval do
      def singleton_method_added(name)
        object_overwrite_method_missing if name == :method_missing
      end
    end
  end

  # Public: ClassMethods to extend in self.included/self.extended
  # Defines an?, is_an?, method_missing
  module ClassMethods
    # Public: method to overwrite original method_missing with a magic one:
    # this method_missing tries to translate British methods to American
    # ones before throwing NoMethodError if neither method was found. Works
    # on a class level.
    #
    #   name - original method name
    #   *args - original method args
    #
    # Example:
    #
    #   # with any British object
    #   british_object.colour    # will be translated into color
    #   british_object.magnetise # will be translated into magnetize
    #
    #   # all method endings are allowed
    #   british_object.surprize!
    #   british_object.surprize?
    #   british_object.surprize=
    #
    #   # complex names are supported
    #   british_object.initialise_something # initialize_something will be called
    #
    # Returns the original method's result
    # Calls original method_missing (if British didn't hook anything)
    # Raises NoMethodError if the method cannot be found
    def class_overwrite_method_missing
      class_eval do
        unless method_defined?(:british_method_missing)
          define_method(:british_method_missing) do |name, *args|

            # do British magic
            americanised_name = name.to_s.gsub(BRITISH_ENDING_PATTERN, ENDINGS)
            return send(americanised_name, *args) if respond_to?(americanised_name)

            # call original method_missing (avoid double original method calls)
            return original_method_missing(name, *args) if caller[0] !~ /method_missing/ && defined?(:original_method_missing)

            # call original parent's method_missing
            method = self.class.superclass.instance_method(:original_method_missing)
            return method.bind(self).call(name, *args) if method
          end
        end

        if instance_method(:method_missing) != instance_method(:british_method_missing)
          alias_method :original_method_missing, :method_missing
          alias_method :method_missing, :british_method_missing
        end
      end
    end

    # Public: method to overwrite original method_missing with a magic one:
    # this method_missing tries to translate British methods to American
    # ones before throwing NoMethodError if neither method was found. Works
    # on an instance level.
    #
    #   name - original method name
    #   *args - original method args
    #
    # Example:
    #
    #   # with any British object
    #   british_object.colour    # will be translated into color
    #   british_object.magnetise # will be translated into magnetize
    #
    #   # all method endings are allowed
    #   british_object.surprize!
    #   british_object.surprize?
    #   british_object.surprize=
    #
    #   # complex names are supported
    #   british_object.initialise_something # initialize_something will be called
    #
    # Returns the original method's result
    # Calls original method_missing (if British didn't hook anything)
    # Raises NoMethodError if the method cannot be found
    def object_overwrite_method_missing
      instance_eval do
        unless respond_to?(:british_method_missing)
          def british_method_missing(name, *args)
            $stdout.flush
            # do British magic
            americanised_name = name.to_s.gsub(BRITISH_ENDING_PATTERN, ENDINGS)
            return send(americanised_name, *args) if respond_to?(americanised_name)

            # call original method_missing (avoid double original method calls)
            return original_method_missing(name, *args) if caller[0] !~ /method_missing/ && defined?(:original_method_missing)
          end
        end

        if method(:method_missing) != method(:british_method_missing)
          alias :original_method_missing :method_missing
          alias :method_missing :british_method_missing
        end
      end
    end
  end
end
