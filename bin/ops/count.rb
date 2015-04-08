#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"
require 'rubygems'
require 'bundler/setup'

APP_PATH = File.expand_path('../../../config/application',  __FILE__)
require File.expand_path('../../../config/boot',  __FILE__)
require APP_PATH
Rails.application.require_environment!


require 'invalesco/aggregates'
require 'ostruct'

Urf::ChampionWinLoss.delete_all

Invalesco::Aggregates.popularity.each do |d|
  d.merge!(d['value'])
  d.delete('value')
  Urf::ChampionWinLoss.create(d)
end
