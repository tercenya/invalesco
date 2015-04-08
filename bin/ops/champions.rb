#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"
require 'rubygems'
require 'bundler/setup'

APP_PATH = File.expand_path('../../../config/application',  __FILE__)
require File.expand_path('../../../config/boot',  __FILE__)
require APP_PATH
Rails.application.require_environment!

Champion.delete_all

json = JSON.parse(File.read("/code/riot/data/static/champions.json"))

json['data'].each do |k,v|
  Champion.create(v)
end
