#!/usr/bin/env ruby
require_relative '../bootstrap'
require 'invalesco/ranking'

collection = {}

Match.all.each do |m|
  m.participants.each do |p|
    champion = p.champion
    gold = p.stats['goldEarned']
    time = m.matchDuration

    gpm = gold / time.to_f

    lane = p.timeline['lane'].downcase.to_sym

    collection[champion.id] ||= {}

    collection[champion.id][lane] ||= { gold: 0, count: 0 }
    collection[champion.id][lane][:gold] += gpm
    collection[champion.id][lane][:count] += 1
  end
end

Urf::ChampionGold.delete_all

collection.each do |k,v|
  golds = v.each_with_object({}) do |(k,v),a|
    a[k] = v[:gold] / v[:count].to_f
  end

  Urf::ChampionGold.create(golds.merge({id: k}))
end