# encoding: utf-8

require 'letters'
require_relative 'helper'
require 'minitest/autorun'
require_relative '../lib/british'

class BritishObject
  include British
  include British::Initialisable

  attr_reader :test
  attr_reader :color
  attr_reader :surprize

  def initialise(test)
    @test = test
    @color = 'red'
  end

  def initialize_something(test)
    test
  end

  def magnetize(test)
    test
  end

  def surprize!
    'Surprise!'
  end

  def surprize?
    'Surprise?'
  end

  def surprize=(test)
    @surprize = test
  end
end

class UberBlackBox
  attr_reader :z

  def initialize(z)
    @z = z
  end
end

class BlackBox < UberBlackBox
  attr_reader :a

  def initialize(a)
    super('Alice & Bob')
    @a = a
  end
end

class MyClass < BlackBox
  include British::Initialisable
  attr_reader :b

  def initialise(b)
    @b = b
    super('bar')
  end
end

describe 'British module' do
  it '#new must call initialize (initialise)' do
    british_object = BritishObject.new('Hello world!')
    british_object.test.must_equal 'Hello world!'
  end

  it 'must correctly process simple names' do
    british_object = BritishObject.new('Hello world!')
    british_object.magnetise('magnet').must_equal 'magnet'
    british_object.surprise!.must_equal 'Surprise!'
    british_object.surprise?.must_equal 'Surprise?'

    british_object.surprise = 'Surprise!!!'
    british_object.surprise.must_equal 'Surprise!!!'
  end

  it 'must correctly process complicated names' do
    british_object = BritishObject.new('Hello world!')
    british_object.initialise_something('test').must_equal 'test'
  end

  it 'mustn\'t brake native american methods' do
    british_object = BritishObject.new('Hello world!')
    british_object.magnetize('magnet').must_equal 'magnet'
  end

  it 'must process different endings (not -ise only)' do
    british_object = BritishObject.new('Hello world!')
    british_object.colour.must_equal 'red'
  end

  it 'must implement is_an? (is_a? alias)' do
    british_object = BritishObject.new('Hello world!')
    british_object.is_an?(Array).must_equal false
  end

  it 'must implement an? (is_an?/is_a? alias)' do
    british_object = BritishObject.new('Hello world!')
    british_object.an?(Array).must_equal false
  end

  it 'must affect all the objects when included globally' do
    String.include British
    'test'.capitalise.must_equal 'Test'
  end

  it 'must affect host 3rd party object when included' do
    Object.include British
    'test'.capitalise.must_equal 'Test'
  end

  it 'must work with the inheritance' do
    my = MyClass.new('foo')
    my.a.must_equal 'bar'
    my.b.must_equal 'foo'
    my.z.must_equal 'Alice & Bob'
  end
end
