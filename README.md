British
========

[![Build Status](https://travis-ci.org/smileart/british.svg?branch=master)](https://travis-ci.org/smileart/british)
[![Inline docs](http://inch-ci.org/github/smileart/british.svg?branch=master)](http://inch-ci.org/github/smileart/british)
[![Gem Version](https://badge.fury.io/rb/british.svg)](https://badge.fury.io/rb/british)

A tiny module which is supposed to help Brits to use Ruby with more comfort.

**WARNING**: This gem was created just for the purpose of an experiment. Use it in your production code at your own risk.

![](/assets/british.gif "WHY?!")

##Why

[![](/assets/screen_1.png)](http://stackoverflow.com/a/17968545 "Screen 1")

[![](/assets/screen_2.png)](http://stackoverflow.com/a/27485116 "Screen 2")

[![](/assets/screen_3.png)](http://blog.codinghorror.com/the-ugly-american-programmer/ "The Ugly American Programmer")



##Installation

```bash
gem install british
```

##Examples

```ruby
# Create classes with `initialise` constructor (British::Initialisable)
# And magic British methods and attributes (British)
class BritishObject < BlackBoxObject
  require 'british'

  # use within your objects only *1 …
  include British
  include British::Initialisable

  attr_reader :color

  # works exactly like an initialize (including `super` usage)
  def initialise(test)
    @test = test
    @color = 'red'

    super('black', 'box', 'arguments')
  end

  def magnetize(test)
    @test
  end
end

british_object = BritishObject.new('Hello UK!')
british_object.test # => 'Hello UK!'

# Use British endings with any method or attribute
british_object.colour    #  => "red"
british_object.magnetise # => "Hello UK!"

# *1 … patch third party or all the system Objects
String.include British
'cheers!'.capitalise # => "Cheers!"

require 'active_support/inflector'
include British

# Use is_an? with classes like an Array!
[].is_an? Array # => true

'cheers!'.capitalise # => "Cheers!"
'oi_ya_bloody_wanker'.camelise # => "OiYaBloodyWanker"
```

##Docs

[RubyDoc.info](http://www.rubydoc.info/gems/british/0.1.0/British "RubyDoc")

##Development
```bash
yard --plugin tomdoc      # generate documentation
open doc/index.html       # open documentation in a browser

rake                      # or `rake test` — run all the tests
rake reek                 # execute reek code smells analysis

rubocop                   # execute rubocop code smells analysis

rake simplecov            # code coverage details
open coverage/index.html  # open coverage report in a browser

inch                      # run inches documentation analysis
```

[Semantic Commit](http://seesparkbox.com/foundry/semantic_commit_messages "Semantic Commit")

##References

* [American and British English spelling differences](https://en.wikipedia.org/wiki/American_and_British_English_spelling_differences)
* [Oxford Dictionaries -ize, -ise, or -yse?](https://youtu.be/-bWSYBUaeYM)
