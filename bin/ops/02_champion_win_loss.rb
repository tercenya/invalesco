#!/usr/bin/env ruby
require_relative '../bootstrap'

require 'invalesco/aggregates'
require 'ostruct'

Urf::ChampionWinLoss.delete_all

map = {}

Match.all.each do |m|
  m.champions.map(&:id).uniq.each do |k|
    map[k] ||= { wins: 0, losses: 0, played: 0 }
    map[k][:played] += 1
  end

  m.participants.each do |p|
    champion = p.champion
    target = p.winner? ? :wins : :losses
    map[champion.id][target] += 1
  end
end

Urf::ChampionWinLoss.delete_all

map.each do |k,v|
  Urf::ChampionWinLoss.create(v.merge(id: k))
end
