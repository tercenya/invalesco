#!/usr/bin/env ruby

require_relative '../bootstrap'

require 'champion_estimator'
require 'core_ext/numeric'

all = Urf::ChampionWinLossUnique.all
ratios = all.map(&:ratio)
best = ratios.max
worst = ratios.min

est = ChampionEstimator.new

xs = (1..10).to_a
ys = (10..20).to_a
min = { i: 0, j: 0, bs: 1 }

xs.each do |i|
  ys.each do |j|
    est.simple_run(:*) do |e,a|
      low = i / 10.to_f
      high = j / 10.to_f
      a[e.id] = ((e.ratio.scale(worst, best, low, high)) ** 3)
    end

    puts "accuracy = #{est.accuracy}"
    # puts "m = #{est.linear_regression}"
    bs = est.brier
    puts "brier = #{bs}"

    if min[:bs] > bs
      min = {i: i, j: j, bs: bs }
    end
  end
end

puts
puts min.inspect
puts min[:i]
puts min[:j]
puts min[:bs]

