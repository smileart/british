require 'minitest/reporters'
require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! [
  Minitest::Reporters::SpecReporter.new
]
