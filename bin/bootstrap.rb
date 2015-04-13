
ENV["RAILS_ENV"] ||= "development"
require 'rubygems'
require 'bundler/setup'

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)
require APP_PATH
Rails.application.require_environment!
