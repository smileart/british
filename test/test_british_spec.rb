# encoding: utf-8

require_relative 'helper'
require 'minitest/autorun'
require_relative '../lib/british'

require_relative './fixtures/classes.rb'
require_relative './fixtures/magic.rb'

describe 'British module' do
  describe 'When included to the British class:' do
    it '#new must call initialize (initialise)' do
      british_object = BritishObject.new('Hello world!')
      british_object.test.must_equal 'Hello world!'
    end

    it '#new must call inherited initialize' do
      british_object = PoshHash.new
      h = Hash.new

      british_object.default.must_equal PoshHash::DEFAULT
      british_object[:nonsense].must_equal PoshHash::DEFAULT

      british_object.color.must_equal 'crimson'

      h[:nonsense].must_be_nil
    end

    it 'must correctly process simple names' do
      british_object = BritishObject.new('Hello world!')

      british_object.magnetize('magnet').must_equal 'magnet'
      british_object.surprize!.must_equal 'Surprize!'
      british_object.surprize?.must_equal 'Surprize?'

      british_object.surprize = 'Surprize!!!'
      british_object.surprize.must_equal 'Surprize!!!'
    end

    it 'must correctly process complicated names' do
      british_object = BritishObject.new('Hello world!')
      british_object.initialize_something('test').must_equal 'test'
    end

    it 'mustn\'t brake native American methods' do
      british_object = BritishObject.new('Hello world!')
      british_object.magnetize('magnet').must_equal 'magnet'
    end

    it 'must process different endings (not -ise only)' do
      british_object = BritishObject.new('Hello world!')
      british_object.color.must_equal 'red'
    end

    it 'must implement is_an? (is_a? alias)' do
      british_object = BritishObject.new('Hello world!')
      british_object.is_an?(Array).must_equal false
    end

    it 'must implement an? (is_an?/is_a? alias)' do
      british_object = BritishObject.new('Hello world!')
      british_object.an?(Array).must_equal false
    end

    it 'mustn\'t break host 3rd party object when included' do
      # Extending standard String
      class String
        include British
      end

      'test'.capitalize.must_equal 'Test'
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

      magic.rabbit_color.must_equal 'white'
      magic.perform.must_equal 'A rabbit from a top hat!'

      real_magic.rabbit_color.must_equal 'white'
      real_magic.perform.must_equal 'Abracadabra! A rabbit from a top hat!'

      witchcraft.rabbit_color.must_equal 'white'
      witchcraft.cat_color.must_equal 'black'
      witchcraft.perform.must_equal 'Oo ee oo ah ah ting tang walla walla bing bang!'
    end

    it 'must throw NoMethodError on unknown methods' do
      -> { BigBadGrayWolf.new.color }.must_raise NoMethodError
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

  describe 'When included to the American class:' do
    it '#new must call initialize' do
      british_object = AmericanObject.new('Hello world!')
      british_object.test.must_equal 'Hello world!'
    end

    it '#new must call inherited initialize' do
      british_object = PoshHash.new
      h = Hash.new

      british_object.default.must_equal PoshHash::DEFAULT
      british_object[:nonsense].must_equal PoshHash::DEFAULT

      british_object.colour.must_equal 'crimson'

      h[:nonsense].must_be_nil
    end

    it 'must correctly process simple names' do
      british_object = AmericanObject.new('Hello world!')

      british_object.magnetise('magnet').must_equal 'magnet'
      british_object.surprise!.must_equal 'Surprize!'
      british_object.surprise?.must_equal 'Surprize?'

      british_object.surprise = 'Surprize!!!'
      british_object.surprise.must_equal 'Surprize!!!'
    end

    it 'must correctly process complicated names' do
      british_object = AmericanObject.new('Hello world!')
      british_object.initialise_something('test').must_equal 'test'
    end

    it 'mustn\'t brake native American methods' do
      british_object = AmericanObject.new('Hello world!')
      british_object.magnetise('magnet').must_equal 'magnet'
    end

    it 'must process different endings (not -ise only)' do
      british_object = AmericanObject.new('Hello world!')
      british_object.color.must_equal 'red'
    end

    it 'must implement is_an? (is_a? alias)' do
      british_object = AmericanObject.new('Hello world!')
      british_object.is_an?(Array).must_equal false
    end

    it 'must implement an? (is_an?/is_a? alias)' do
      british_object = AmericanObject.new('Hello world!')
      british_object.an?(Array).must_equal false
    end

    it 'must affect host 3rd party object when included' do
      # Extending standard String
      class String
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

  describe 'When object being extended with it:' do
    it 'must correctly process simple names' do
      freeloader = Freeloader.new('foo', 'Hello world!')
      freeloader.extend(British)

      freeloader.magnetise('magnet').must_equal 'magnet'
      freeloader.surprise!.must_equal 'Surprise!'
      freeloader.surprise?.must_equal 'Surprise?'

      freeloader.surprise = 'Surprise!!!'
      freeloader.surprise.must_equal 'Surprise!!!'
    end

    it 'must correctly process complicated names' do
      freeloader = Freeloader.new('foo', 'Hello world!')
      freeloader.extend(British)

      freeloader.initialise_something('test').must_equal 'test'
    end

    it 'mustn\'t brake native American methods' do
      freeloader = Freeloader.new('foo', 'Hello world!')
      freeloader.extend(British)

      freeloader.magnetize('magnet').must_equal 'magnet'
    end

    it 'must process different endings (not -ise only)' do
      freeloader = Freeloader.new('foo', 'Hello world!')
      freeloader.extend(British)

      freeloader.colour.must_equal 'red'
    end

    it 'must implement is_an? (is_a? alias)' do
      freeloader = Freeloader.new('foo', 'Hello world!')
      freeloader.extend(British)

      freeloader.is_an?(Array).must_equal false
    end

    it 'must implement an? (is_an?/is_a? alias)' do
      freeloader = Freeloader.new('foo', 'Hello world!')
      freeloader.extend(British)

      freeloader.an?(Array).must_equal false
    end

    it 'must patch 3rd party object when used in #extend' do
      freeloader = Freeloader.new('foo', 'Hello World!')
      freeloader.extend(British)

      freeloader.a.must_equal 'bar'
      freeloader.b.must_equal 'foo'
      freeloader.z.must_equal 'Alice & Bob'
    end

    it 'mustn\'t be broken by other\'s magic' do
      performer = Muggle.new.extend(British)
      performer.perform.must_equal 'Voilà! A rabbit from a top hat!'
    end

    it 'mustn\'t be broken by singleton method' do
      freeloader = Freeloader.new('foo', 'Hello World!')
      freeloader.extend(British)

      class << freeloader
        def method_missing(name, *_)
          'Hello there! I feel magic!'
        end
      end

      freeloader.whatever.must_equal 'Hello there! I feel magic!'
      freeloader.colour.must_equal 'red'
    end

    it 'must throw NoMethodError on unknown methods' do
      freeloader = Freeloader.new('foo', 'Hello World!')
      freeloader.extend(British)

      -> { freeloader.glamour }.must_raise NoMethodError
    end

    it 'must correctly show nil in NoMethodError messages' do
      begin
        n = nil
        n.extend(British)
        n.nonsense
      rescue NoMethodError => e
        if RUBY_VERSION == '2.0.0'
          e.message.must_equal 'private method `include\' called for NilClass:Class'
        else
          e.message.must_equal 'undefined method `nonsense\' for nil:NilClass'
        end
      end
    end
  end
end
