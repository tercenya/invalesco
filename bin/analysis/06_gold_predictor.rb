#!/usr/bin/env ruby

require_relative '../bootstrap'

require 'champion_estimator'
require 'brier'

bs = Brier.new

xs = []
ys = []
@accuracy = { correct: 0, count: 0 }

Match.all.each do |m|
  blue_gold = m.blue_participants.map { |e| e.stats['goldEarned'] }.reduce(:+)
  red_gold = m.red_participants.map { |e| e.stats['goldEarned'] }.reduce(:+)

  ## boolean predictor
  # prediction = blue_gold > red_gold ? 1.0 : 0.0
  ## relative predictor
  prediction = blue_gold.to_f / ( blue_gold + red_gold)
  correct = (m.winner == :blue) ? 1 : 0
  @accuracy[:correct] += correct
  @accuracy[:count] += 1

  bs.observe(prediction, correct)

  ys << prediction
  xs << correct

end

puts "accuracy = #{@accuracy[:correct].to_f / @accuracy[:count] }"
lr = SimpleLinearRegression.new(xs, ys)
puts "m=#{lr.slope}"

puts "bs = #{bs.score}"
