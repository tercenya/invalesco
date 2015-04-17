#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'json'

require 'active_support'

count = []
Dir['/code/riot/data/api_challenge/*.json'].each do |f|
  lines = File.read(f)
  count << JSON.parse(lines).count
end

puts count.inject(:+) / count.size
