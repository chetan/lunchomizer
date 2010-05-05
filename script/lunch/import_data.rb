#!/usr/bin/env ruby
require File.expand_path('../../../config/boot',  __FILE__)
require RAILS_ROOT + '/config/environment'

RAILS_TMP = RAILS_ROOT + '/tmp'

require 'rubygems'
require 'geokit'
require 'json'
require 'pp'

data = JSON.load(File.new(RAILS_TMP + "/data.json"))
data['feed'].keys # => ["category", "author", "title", "openSearch$startIndex", "id", "openSearch$totalResults", "xmlns$gsx", "xmlns$openSearch", "entry", "link", "updated", "xmlns"]

data['feed']['entry'].first # => {"gsx$category"=>{"$t"=>"Carts,Street_Meat,Salads"}, "gsx$longitude"=>{"$t"=>"-73.972084"}, "category"=>[{"term"=>"http://schemas.google.com/spreadsheets/2006#list", "scheme"=>"http://schemas.google.com/spreadsheets/2006"}], "gsx$phone"=>{"$t"=>""}, "title"=>{"$t"=>"-73.972084", "type"=>"text"}, "gsx$description"=>{"$t"=>"Best greek salad from a cart"}, "gsx$zipcode"=>{"$t"=>""}, "gsx$title"=>{"$t"=>"100% Halal & Healthy Cart"}, "id"=>{"$t"=>"http://spreadsheets.google.com/feeds/list/pp3LMci9UjS4MwJEjJFO_Ww/default/public/values/40qnt"}, "gsx$closed"=>{"$t"=>""}, "gsx$address"=>{"$t"=>""}, "gsx$latitude"=>{"$t"=>"40.760571"}, "gsx$xstreet"=>{"$t"=>"55th St. btw. Mad+Park"}, "content"=>{"$t"=>"latitude: 40.760571, title: 100% Halal & Healthy Cart, xstreet: 55th St. btw. Mad+Park, description: Best greek salad from a cart, category: Carts,Street_Meat,Salads, link: http://midtownlunch.com/category/100-halal-healthy/", "type"=>"text"}, "link"=>[{"href"=>"http://spreadsheets.google.com/feeds/list/pp3LMci9UjS4MwJEjJFO_Ww/default/public/values/40qnt", "rel"=>"self", "type"=>"application/atom+xml"}], "gsx$link"=>{"$t"=>"http://midtownlunch.com/category/100-halal-healthy/"}, "updated"=>{"$t"=>"2010-03-20T18:10:30.876Z"}}

locations = data['feed']['entry']

test = locations.first
test.keys # => ["gsx$category", "gsx$longitude", "category", "gsx$phone", "title", "gsx$description", "gsx$zipcode", "gsx$title", "id", "gsx$closed", "gsx$address", "gsx$latitude", "gsx$xstreet", "content", "link", "gsx$link", "updated"]

pp test
pp test['content']
pp test['gsx$longitude']