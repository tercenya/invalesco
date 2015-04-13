#!/usr/bin/env ruby

require_relative '../bootstrap'
Champion.delete_all

json = JSON.parse(File.read("/code/riot/data/static/champions.json"))

json['data'].each do |k,v|
  Champion.create(v)
end
