Gem::Specification.new do |s|
  s.name        = 'british'
  s.version     = '0.4.2'
  s.licenses    = ['MIT']
  s.summary     = 'A tiny module which is supposed to help Brits to use Ruby with more comfort'
  s.description = 'Allows to use alternative words endings: -ise instead of -ize etc. Defines `is_an?` as an alias of the is_a? method. Provides a module to use `initialise` in your classes.'
  s.authors     = ['Serge Bedzhyk']
  s.email       = 'smileart21@gmail.com'
  s.files       = Dir['lib/*.rb']
  s.homepage    = 'https://github.com/smileart/british'

  s.add_development_dependency 'bundler',            '~> 2.0'
  s.add_development_dependency 'minitest',           '~> 5.13'
  s.add_development_dependency 'minitest-reporters', '~> 1.4'
  s.add_development_dependency 'rake',               '~> 13.0'
  s.add_development_dependency 'simplecov',          '~> 0.9'
  s.add_development_dependency 'm',                  '~> 1.5'
  s.add_development_dependency 'coveralls',          '~> 0.8'
  s.add_development_dependency 'letters',            '~> 0.4'
  s.add_development_dependency 'yard',               '>= 0.9.20'
  s.add_development_dependency 'rdoc',               '~> 6.2'
  s.add_development_dependency 'gitignore',          '~> 0.1'
  s.add_development_dependency 'rubocop',            '~> 0.76'
  s.add_development_dependency 'inch',               '>= 0.9.0.rc1'
  s.add_development_dependency 'byebug',             '~> 11.0'
  s.add_development_dependency 'reek',               '~> 5.5'
  s.add_development_dependency 'benchmark-ips',      '~> 2.7'
  s.add_development_dependency 'ruby-prof',          '~> 1.0'
end
