# -*- mode: ruby -*-
# vim: set ft=ruby:

desc 'Run integration tests'
task 'integration-test' do
  sh %q{kitchen test}
end

desc 'Run style and best practice checks'
task :lint do
  sh %q{bundle exec knife cookbook test --cookbook-path .. devpi}
end

desc 'Remove all generated files'
task 'maintainer-clean' do
  sh %q{vagrant destroy -f}
  sh %q{kitchen destroy all --parallel}
  rmtree 'tmp'
  rmtree 'vendor'
  rmtree '.kitchen'
  rmtree '.vagrant'
end


begin
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new :foodcritic do |t|
    t.options = {:fail_tags => ['correctness']}
  end
  Rake::Task[:lint].enhance [:foodcritic]
rescue LoadError
  puts '>>>>> FoodCritic gem failed to load.'
  puts '>>>>> Lint will not included FC checks.'
end
