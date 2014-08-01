source 'https://rubygems.org'

gem 'berkshelf', '~> 3.1.4'

group :lint do
  gem 'foodcritic', '~> 4.0.0'
  gem 'rubocop', '~> 0.24.1'
end

group :unit do
  gem 'chefspec',   '~> 3.1'
end

group :kitchen do
  gem 'test-kitchen', '~> 1.2.1'
  gem 'kitchen-vagrant', '~> 0.15.0'
end

group :development do
  gem 'guard', '~> 2.4'
  gem 'guard-kitchen'
  gem 'guard-foodcritic'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake'
end
