require_relative '../lib/british'
require 'letters'

include British

# Internal: an even more distant ancestor of the BlackBox
class SuperUberBlackBox
  attr_reader :x

  def initialize(x)
    @x = x
  end
end

# Internal: a distant ancestor of the BlackBox
class SuperBlackBox < SuperUberBlackBox
  attr_reader :z

  def initialize(z)
    @z = z
    super('Alice & Bob')
  end
end

# Internal: Kind of third party code I have no influence on
class BlackBox < SuperBlackBox
  attr_reader :a

  def initialize(a)
    @a = a
    super('Zorro')
  end
end

# Internal: My own class (descendant of the BlackBox)
class MyClass < BlackBox
  include British::Initialisable
  attr_reader :b

  def initialise(b)
    @b = b
    super('bar')
  end
end

my = MyClass.new('foo')
my.o
# => <MyClass:0x007fad8286e188 @b="foo", @a="bar", @z="Zorro", @x="Alice & Bob">
