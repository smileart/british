# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :dev)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test' << 'lib'
  test.pattern = 'test/**/*.rb'
  test.verbose = true
end

desc 'Code coverage detail'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end

require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.config_file = 'config.reek' # Defaults to nothing.
end

task default: :test
