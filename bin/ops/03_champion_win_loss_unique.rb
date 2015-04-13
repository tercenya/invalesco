#!/usr/bin/env ruby
require_relative '../bootstrap'

require 'invalesco/aggregates'
require 'ostruct'

map = {}

Match.all.each do |m|
  uniq = m.champions.group_by(&:id).inject([]) do |a,(k,v)|
    a << k if v.size == 1
    a
  end

  # puts m.champions.map(&:name).join(", ")

  players = m.participants.select { |e| e.champion.id.in?(uniq) }
  # puts players.map(&:champion).map(&:name).join(', ')

  players.each do |p|
    champion = p.champion
    map[champion.id] ||= { wins: 0, losses: 0 }
    target = p.winner? ? :wins : :losses
    map[champion.id][target] += 1
  end
end

Urf::ChampionWinLossUnique.delete_all

map.each do |k,v|
  Urf::ChampionWinLossUnique.create(v.merge(id: k))
end

