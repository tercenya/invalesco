#!/usr/bin/env ruby

require_relative '../bootstrap'

require 'champion_estimator'
require 'core_ext/numeric'
require 'core_ext/enumerable'

all = Urf::ChampionWinLossUnique.all
ratios = all.map(&:ratio)
stdev = ratios.standard_deviation
average = ratios.mean

puts "Average: #{average}"
puts "stdev: #{stdev}"

all = Urf::ChampionWinLoss.all
ratios = all.map(&:ratio)
best = ratios.max
worst = ratios.min

best_s = (best - average) / stdev
worst_s = (worst - average) / stdev

est = ChampionEstimator.new

xs = (1..25).to_a
min = { i: 0, j: 0, bs: 1 }

xs.each do |i|
  est.simple_run(:+) do |e,a|
    o = (e.ratio - average) / stdev
    val = 1 + o.scale(worst_s, best_s, 0, i.to_f/10)
    # puts "#{e.ratio} => #{val}"
    a[e.id] = val
  end

  puts "accuracy = #{est.accuracy}"
  bs = est.brier
  puts "brier = #{bs}"

  if min[:bs] > bs
    min = {i: i, j: j, bs: bs, acc: est.accuracy }
  end
end

puts
puts min.inspect
puts min[:i]
puts min[:j]
puts min[:bs]
puts min[:acc]
