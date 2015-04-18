#!/usr/bin/env ruby

require_relative 'bootstrap'
include Rails.application.routes.url_helpers
Rails.application.routes.default_url_options[:host] = 'localhost:3000'
Rails.application.routes.default_url_options[:script_name] = '/invalesco'



urls = [
  root_url,
  urf_champions_url,
  urf_champions_distribution_url,
  urf_teams_level_url,
  urf_teams_rank_url,
  urf_teams_rank_delta_url,
  urf_teams_rank_upsets_url
]

urls.each do |u|
  puts u
  `curl #{u} -o /dev/null`
end

