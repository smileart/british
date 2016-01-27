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
  }

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
    # Returns nothing.
    def self.included(host_class)
      unless host_class == Object
        # alias parent's initialise method
        host_class.superclass.class_eval do
          alias_method :initialise, :initialize
        end

        # create own initialize method
        define_method :initialize do |*args|
          initialise(*args)
        end
      end
    end
  end

  # Public: British alias of native is_a? method
  # Returns the original method's result
  def is_an?(*args)
    is_a?(*args) if self.respond_to?(:is_a?)
  end

  # Public: additional alias for is_an?/is_a? method
  alias_method :an?, :is_an?

  # Public: Magic method which tries to translate British methods to American
  # methods before throwing NoMethodError if neither method was found.
  #
  #   name - original method name
  #   *args - original method args
  #
  # Example
  #
  #   # with any British object
  #   british_object.colour    # will be translated into color
  #   british_object.magnetise # will be translated into magnetize
  #
  #   # all method endings age allowed
  #   british_object.surprize!
  #   british_object.surprize?
  #   british_object.surprize=
  #
  #   # complex names are supported
  #   british_object.initialise_something # initialize_something will be called
  #
  # Returns the original method's result
  # Raises NoMethodError if the method cannot be found.
  def method_missing(name, *args)
    name = name.to_s

    ENDINGS.each_pair do |bre_e, ame_e|
      next unless name.include?(bre_e)

      british_ending_pattern = /#{bre_e}(?=_|-|$|\?|\!|=)/
      americanised_name = name.gsub(british_ending_pattern, ame_e)

      return send(americanised_name, *args) if respond_to?(americanised_name)
    end

    fail NoMethodError, "undefined method `#{name}' for #{self}"
  end
end
