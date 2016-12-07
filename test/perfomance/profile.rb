require_relative '../../lib/british'
require 'ruby-prof'

result = RubyProf.profile do
  class BritishClass
    include British::Initialisable

    attr_reader :colour

    def initialise(colour)
      @colour = colour
    end
  end

  class AmericanClass
    attr_reader :color

    def initialize(color)
      @color = color
    end
  end

  class BilingualClass
    include British
    attr_reader :color

    def initialize(color)
      @color = color
    end
  end

  american = AmericanClass.new('red')
  british  = BritishClass.new('red')
  migrant  = AmericanClass.new('red').extend(British)

  american.color
  british.color
  migrant.color
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)
