# https://en.wikipedia.org/wiki/Magic_word
# http://i.giphy.com/e1aCrn9l9u4da.gif

# MagicHat:
# — has its own authentic method_missing
# — mustn't be overwritten by any British magic
# — must be callable by super and through inheritance
class MagicHat
  def method_missing(name, *_)
    'A rabbit from a top hat!' if name == :perform
  end
end

# MagicClass:
# — has American method (must be callable by British magic)
# — inherits method_missing from MagicHat (must call it when method is missing)
class MagicClass < MagicHat
  include British

  def rabbit_color
    'white'
  end
end

# RealMagicClass:
# — has inherited American method (must be callable by British magic)
# — has its own method_missing (must call it on method_missing when not British)
# — uses `super`, must call method_missing through MagicClass from MagicHat
class RealMagicClass < MagicClass
  def method_missing(name, *args)
    'Abracadabra! ' + super(name, *args)
  end
end

# Witchcraft:
# — has its own method_missing, overwrites parents method_missing
class Witchcraft < MagicClass
  def method_missing(_name, *_)
    'Oo ee oo ah ah ting tang walla walla bing bang!'
  end
end

# InheritedWitchcraft
# — has inherited American method (must be callable by British magic)
# — has its own American method (must be callable by British magic inherited from MagicClass)
# — has inherited method_missing from Witchcraft which overwrites parents' method_missing
class InheritedWitchcraft < Witchcraft
  def cat_color
    'black'
  end
end

# Muggle:
# — has inherited method_missing from MagicHat
# — uses `super`, must call method_missing from MagicHat
class Muggle < MagicHat
  def method_missing(name, *args)
    'Voilà! ' + super(name, *args)
  end
end
