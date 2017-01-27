Gem::Specification.new do |s|
  s.name        = 'british'
  s.version     = '0.4.1'
  s.licenses    = ['MIT']
  s.summary     = 'A tiny module which is supposed to help Brits to use Ruby with more comfort'
  s.description = 'Allows to use alternative words endings: -ise instead of -ize etc. Defines `is_an?` as an alias of the is_a? method. Provides a module to use `initialise` in your classes.'
  s.authors     = ['Serge Bedzhyk']
  s.email       = 'smileart21@gmail.com'
  s.files       = Dir['lib/*.rb']
  s.homepage    = 'https://github.com/smileart/british'

  s.add_development_dependency 'bundler',            '~> 1.10'
  s.add_development_dependency 'minitest',           '~> 5.0'
  s.add_development_dependency 'minitest-reporters', '~> 1.1'
  s.add_development_dependency 'rake',               '~> 12.0'
  s.add_development_dependency 'simplecov',          '~> 0.12'
  s.add_development_dependency 'm',                  '~> 1.5'
  s.add_development_dependency 'coveralls',          '~> 0.8'
  s.add_development_dependency 'letters',            '~> 0.4'
  s.add_development_dependency 'yard',               '~> 0.8'
  s.add_development_dependency 'rdoc',               '~> 5.0'
  s.add_development_dependency 'gitignore',          '~> 0.1'
  s.add_development_dependency 'rubocop',            '~> 0.47'
  s.add_development_dependency 'inch',               '~> 0.7'
  s.add_development_dependency 'byebug',             '~> 9.0'
  s.add_development_dependency 'reek',               '~> 4.5'
  s.add_development_dependency 'benchmark-ips',      '~> 2.7'
  s.add_development_dependency 'ruby-prof',          '~> 0.16'
end
