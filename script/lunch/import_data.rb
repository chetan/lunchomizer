#!/usr/bin/env ruby

ROOT_PATH = File.expand_path('../../..',  __FILE__)
ENV_PATH  = File.expand_path(ROOT_PATH + '/config/environment',  __FILE__)
BOOT_PATH = File.expand_path(ROOT_PATH + '/config/boot',  __FILE__)
APP_PATH  = File.expand_path(ROOT_PATH + '/config/application',  __FILE__)
RAILS_TMP = ROOT_PATH + '/tmp'

require BOOT_PATH
require ENV_PATH
require APP_PATH

require 'rubygems'
require 'geokit'
require 'json'
require 'pp'

# source: http://spreadsheets.google.com/feeds/list/pp3LMci9UjS4MwJEjJFO_Ww/default/public/values?alt=json
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
