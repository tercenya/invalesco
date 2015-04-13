#!/usr/bin/env ruby
require_relative '../bootstrap'

require 'invalesco/aggregates'
require 'ostruct'

Urf::ChampionWinLoss.delete_all

Invalesco::Aggregates.popularity.each do |d|
  d.merge!(d['value'])
  d.delete('value')
  Urf::ChampionWinLoss.create(d)
end
