#!/usr/bin/env ruby
require_relative '../bootstrap'
require 'urf/player_rank_distribution'

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
