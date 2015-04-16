#!/usr/bin/env ruby

require_relative '../bootstrap'

require 'champion_estimator'

est = ChampionEstimator.new

est.simple_run(:+) do |e,a|
  a[e.id] = e.ratio * 100
end

puts "accuracy = #{est.accuracy}"
puts "m = #{est.linear_regression}"
puts "brier = #{est.brier}"

