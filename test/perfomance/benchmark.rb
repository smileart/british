require_relative '../../lib/british'
require 'benchmark/ips'

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

native_test = 'test'
british_test = 'test'.extend(British)

Benchmark.ips do |x|
  x.report('capitalize') {
    native_test.capitalize
  }

  x.report('capitalise') {
    british_test.capitalise
  }

  x.compare!
end

# ======================================================

american = AmericanClass.new('red')
british  = BritishClass.new('red')
migrant  = AmericanClass.new('red').extend(British)

Benchmark.ips do |x|
  x.report('American direct') {
    american.color
  }

  x.report('British magic') {
    british.color
  }

  x.report('Migrant magic') {
    migrant.colour
  }

  x.compare!
end

# ======================================================
