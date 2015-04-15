#!/usr/bin/env ruby
require_relative '../bootstrap'

counts = {}

def points(participant)
  case participant.tier
  when :unranked
    0
  when :bronze
    1
  when :silver
    2
  when :gold
    3
  when :platinum
    4
  when :diamond
    5
  when :challenger
    6
  when :master
    7
  else
    throw 'unknown tier'
  end
end

def team_points(participants)
  participants.map { |e| points(e) }.reduce(:+)
end

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
