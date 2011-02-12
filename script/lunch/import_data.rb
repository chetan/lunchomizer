#!/usr/bin/env ruby
require File.expand_path('../../../config/boot',  __FILE__)
require RAILS_ROOT + '/config/environment'

RAILS_TMP = RAILS_ROOT + '/tmp'

require 'rubygems'
require 'geokit'
require 'json'
require 'pp'

data = JSON.load(File.new(RAILS_TMP + "/data.json"))

def extract(t)
    ret = {}
    t.keys.each { |k| 
        if k =~ /^gsx\$(.+)$/ then
            ret[$1] = t[k]["$t"].strip
        end
    }
    ret
end

locations = data['feed']['entry']

locations.each do |loc|

    c = extract(loc)

    r = Restaurant.new
    r.name = c["title"]
    r.categories = c["category"]
    r.address = c["address"]
    r.xstreet = c["xstreet"]
    r.lat = c["latitude"]
    r.lng = c["longitude"]
    r.zip = c["zipcode"]
    r.phone = c["phone"]
    r.description = c["description"]
    r.link = c["link"]
    r.closed = (c["closed"] == "TRUE" ? 1 : 0)
    r.updated = loc["updated"]["$t"]

    puts "saving: #{r.name}"
    r.save!
end