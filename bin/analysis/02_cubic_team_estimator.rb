#!/usr/bin/env ruby

ENV["RAILS_ENV"] ||= "development"
require 'rubygems'
require 'bundler/setup'

APP_PATH = File.expand_path('../../../config/application',  __FILE__)
require File.expand_path('../../../config/boot',  __FILE__)
require APP_PATH
Rails.application.require_environment!

require 'simple_linear_regression'
require 'ostruct'

# build the "points per champion"

class Numeric
  def scale(a1, a2, b1, b2)
    ((b2-b1) * (self - a1)) / (a2 - a1) + b1
  end
end 

all = Urf::ChampionWinLoss.all
ratios = all.map(&:ratio)
best = ratios.max
puts "best is #{best}"
worst = ratios.min
puts "worst is #{worst}"

points = all.each_with_object({}) do |e,a|
  a[e.id] = ((e.ratio.scale(worst, best, 0.1, 0.5)) ** 3 * 1000).to_i
end

accuracy = 0
results = []
count = Match.all.size

Match.all.each_with_index do |m,i|
  blue_points = m.blue_characters.map { |c| points[c.id] }.reduce(:+).to_i
  red_points = m.red_characters.map { |c| points[c.id] }.reduce(:+).to_i
  predict = blue_points > red_points ? :blue : :red
  correct = predict == m.winner
  results << OpenStruct.new(blue: blue_points, red: red_points, winner: m.winner)
  # puts "blue: #{blue_points}\tred: #{red_points}\t prediction: #{predict}\twinner: #{m.winner}\tcorrect: #{correct}"
  accuracy += 1 if correct
  puts i if i % 1000 == 0
end

puts "accuracy: #{accuracy / count.to_f * 100} %"

xs = results.each_with_object([]) do |e,a|
  a << (e.winner == :blue ? 1 : 0)
end

ys = results.each_with_object([]) do |e,a|
  a << (e.blue / e.red.to_f)
end

lr = SimpleLinearRegression.new(xs, ys)
puts "m=#{lr.slope}"
