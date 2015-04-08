
source 'https://rubygems.org'

## Rails
gem 'rails', '4.2.1'
## Rails pipeline
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'turbolinks'

# database
gem 'sqlite3'
gem 'mongoid'

case RUBY_PLATFORM
when /darwin/
 # use apple's built-in javascript
else
  gem 'therubyracer'
end

# Views and frontend gems
gem 'haml-rails'
gem 'kramdown'
gem 'kramdown-haml'

## Utilities
gem 'highline', require: false
gem 'rest-client'

gem 'passenger'

group :development do
  gem 'thin'

  # code quality
  gem 'rubocop', require: false

  gem 'powder'
  gem 'guard-pow'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'

  gem 'spring'
  gem 'rspec'
  gem 'shoulda'

  gem 'guard-bundler'
  gem 'guard-rspec'
  # gem 'guard-spring'

  gem 'jazz_hands', github: 'camerontaylor/jazz_hands'

  gem 'letter_opener'
  gem 'rb-fsevent', group: :darwin

  # require these later in rails_helper, otherwise you get the wrong pieces loaded
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'factory_girl_rails', require: false
  gem 'faker'
end


group :development, :doc do
  gem 'yard'
end
