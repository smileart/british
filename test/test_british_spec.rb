# encoding: utf-8

require_relative 'helper'
require 'minitest/autorun'
require_relative '../lib/british'

require_relative './fixtures/classes.rb'
require_relative './fixtures/magic.rb'

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
    # Extending standard String
    class String
      include British
    end

    'test'.capitalise.must_equal 'Test'
  end

  it 'must affect host 3rd party object when included' do
    # Extending standard object
    class Object
      include British
    end

    'test'.capitalise.must_equal 'Test'
  end

  it 'must work with the inheritance' do
    my = MyClass.new('foo')
    my.a.must_equal 'bar'
    my.b.must_equal 'foo'
    my.z.must_equal 'Alice & Bob'
  end

  it 'mustn\'t be broken by other\'s magic' do
    magic      = MagicClass.new
    real_magic = RealMagicClass.new
    witchcraft = InheritedWitchcraft.new

    magic.rabbit_colour.must_equal 'white'
    magic.perform.must_equal 'A rabbit from a top hat!'

    real_magic.rabbit_colour.must_equal 'white'
    real_magic.perform.must_equal 'Abracadabra! A rabbit from a top hat!'

    witchcraft.rabbit_colour.must_equal 'white'
    witchcraft.cat_colour.must_equal 'black'
    witchcraft.perform.must_equal 'Oo ee oo ah ah ting tang walla walla bing bang!'
  end

  it 'must throw NoMethodError on unknown methods' do
    -> { BigBadGrayWolf.new.colour }.must_raise NoMethodError
  end

  it 'must correctly show nil in NoMethodError messages' do
    begin
      NilClass.include British
      nil.nonsense
    rescue NoMethodError => e
      if RUBY_VERSION == '2.0.0'
	      e.message.must_equal 'private method `include\' called for NilClass:Class'
      else
        e.message.must_equal 'undefined method `nonsense\' for nil:NilClass'
	    end
    end
  end
end
