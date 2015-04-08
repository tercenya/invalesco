ENV['RAILS_ENV'] ||= 'test'

require_relative 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # we'll expung the test database ourselves with DatabaseCleaner
  #   and any use of transactions break capybara tests
  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location! # we like convension over configuration
end
