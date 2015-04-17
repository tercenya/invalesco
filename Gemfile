
source 'https://rubygems.org'

## Rails
gem 'rails', '4.2.1'
## Rails pipeline
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

#gem 'turbolinks'
# generate rails app to static content
gem 'actionpack-page_caching'

# database
gem 'sqlite3'
gem 'mongoid'

case RUBY_PLATFORM
when /darwin/
 # use apple's built-in javascript
else
  gem 'therubyracer'
end

# Views and frontend gem
gem 'kramdown'
gem 'haml-rails'
gem 'haml-kramdown'

## Utilities
gem 'highline', require: false
gem 'rest-client'

gem 'passenger'

group :development do
  gem 'thin'

  gem 'powder'
  gem 'guard-pow'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'

  gem 'spring'

  gem 'guard-bundler'

  gem 'jazz_hands', github: 'camerontaylor/jazz_hands'

  gem 'rb-fsevent', group: :darwin
end

group :development, :doc do
  gem 'yard'
end
