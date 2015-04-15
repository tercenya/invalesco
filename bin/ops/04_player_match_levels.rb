#!/usr/bin/env ruby
require_relative '../bootstrap'

counts = {}

Match.all.each do |match|
  counts[match.combined_levels] ||= 0
  counts[match.combined_levels] += 1
end

Urf::TeamLevelDistribution.delete_all

counts.each do |k,v|
  Urf::TeamLevelDistribution.create({ id: k, count: v })
end
