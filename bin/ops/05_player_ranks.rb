#!/usr/bin/env ruby
require_relative '../bootstrap'
require 'urf/player_rank_distribution'
require 'invalesco/ranking'

counts = {}

include Ranking

Match.all.each do |match|
  match.team_participants.each do |team_participants|
    total = team_points(team_participants)
    counts[total] ||= { wins: 0, losses: 0 }

    target = team_participants.first.winner? ? :wins : :losses
    counts[total][target] += 1
  end
end

Urf::TeamRankDistribution.delete_all

counts.each do |k,v|
  Urf::TeamRankDistribution.create(v.merge(id: k))
end
