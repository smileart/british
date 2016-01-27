Gem::Specification.new do |s|
  s.name        = 'british'
  s.version     = '0.1.1'
  s.licenses    = ['MIT']
  s.summary     = 'A tiny module that is supposed to help Brits to use Ruby with more comfort.'
  s.description = 'Allows to use alternative words endings: -ise instead of -ize etc. Defines `is_an?` as an alias of the is_a? method. Provides module to use `initialise` in your classes.'
  s.authors     = ['Serge Bedzhyk']
  s.email       = 'smileart21@gmail.com'
  s.files       = Dir['lib/*.rb'] + Dir['bin/*']
  s.homepage    = 'https://github.com/smileart/british'
end
