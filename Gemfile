source 'https://rubygems.org'

## Utilities
gem 'highline'
gem 'rest-client'

gem 'addressable'
gem 'activesupport'

group :development do
  gem 'thin'
end

group :development, :test do
  # error catching and debugging tools
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'

  # testing tools
  gem 'rspec'
  gem 'rspec-rails'

  # require these later in rails_helper, otherwise you get the wrong pieces loaded
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'factory_girl_rails', require: false
  gem 'faker'
end

group :development, :doc do
  gem 'yard'
end
