#!/usr/bin/env ruby
require_relative '../bootstrap'
require 'invalesco/ranking'

counts = {}

include Ranking

Match.all.each do |match|
  blue_points = team_points(match.blue_participants)
  red_points = team_points(match.red_participants)

  total = blue_points + red_points
  delta = (blue_points - red_points).abs
  winner = blue_points > red_points ? :blue : :red

  counts[delta] ||= { count: 0, upset: {} }
  counts[delta][:upset][total] ||= 0

  upset = match.winner == winner ? 0 : 1

  counts[delta][:upset][total] += upset
  counts[delta][:count] += 1
end

Urf::TeamRankSkew.delete_all

counts.each do |k,v|
  Urf::TeamRankSkew.create(v.merge(id: k))
end
