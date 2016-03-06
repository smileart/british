# Fully BritishObject:
# — american methods/attributes could be called with British magic
# — has is_an? method to use with classes beginning with vowel
# — initialise could be used instead if initialize
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

# Second generation BlackBox
# — not accessible by British user
class UberBlackBox
  attr_reader :z

  def initialize(z)
    @z = z
  end
end

# First generation BlackBox
# — not accessible by British user
class BlackBox < UberBlackBox
  attr_reader :a

  def initialize(a)
    super('Alice & Bob')
    @a = a
  end
end

# Our own class
# — initialisable by British initialise method
# — must support `super` to call parent's (BlackBox) initialize
class MyClass < BlackBox
  include British::Initialisable
  attr_reader :b

  def initialise(b)
    @b = b
    super('bar')
  end
end

# Bad guy — BigBadGrayWolf
# — just want to be British but have not any methods
# — must throw NoMethodError exceptions with nice native messages (even with nil)
class BigBadGrayWolf
  include British
end
