# -*- mode: ruby -*-
# vim: set ft=ruby:

require 'rspec/core/rake_task'


desc 'Run unit tests'
RSpec::Core::RakeTask.new 'unit-test'

desc 'Run style and best practice checks'
task :lint do
  sh %q{bundle exec knife cookbook test --cookbook-path .. devpi}
end

desc 'Remove all generated files'
task 'maintainer-clean' do
  rmtree 'tmp'
end


begin
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new :foodcritic do |t|
    puts "Running foodcritic check on devpi"
    t.options = {:fail_tags => ['correctness']}
  end
  Rake::Task[:lint].enhance [:foodcritic]
rescue LoadError
  puts ">>>>> FoodCritic gem failed to load."
  puts ">>>>> Lint will not included FC checks."
end
