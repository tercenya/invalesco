#!/usr/bin/env ruby

require_relative '../bootstrap'
require 'invalesco/ranking'

include Ranking

xs = []
ys = []

Match.all.each do |m|
  m.participants.each do |p|
    xs << points(p)
    ys << Urf::ChampionWinLossUnique.find(p.champion.id).ratio
  end
end

lr = SimpleLinearRegression.new(xs, ys)
puts "m=#{lr.slope}"
