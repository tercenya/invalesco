#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'active_support/time'

require_relative '../lib/riot/api'


def timespan
  now = Time.now
  earliest = now.ago(8.hours)

  # round to the nearest 5 minutes
  ago = earliest.change(min: (earliest.min - earliest.min % 5))

  # don't round down
  ago = ago + 5.minutes if ago < earliest

  # get all 5-minute internval between then and about an hour ago
  last = now - 1.hour
  Range.new(ago.to_i, last.to_i).step(5.minutes)
end


while(true) do
  target_time = Time.now + 6.minutes

  [:na, :euw].each do |region|
    api = Riot::Api.new(region)

    timespan.each do |epoch|
      matches = api.api_challenge(epoch)
      matches.each do |match|
        begin
          api.match(match.to_i)
        rescue
          puts "FAILED"
	  sleep(1.25)
          next
        end
      end
    end
  end

  delta = target_time - Time.now
  if delta > 0
    puts "SLEEPING"
    sleep(delta)
  end
end
