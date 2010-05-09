
CLOSE = 0.1
NEAR  = 0.25
FAR   = 0.45

require 'gmap'
include GMap

class LunchController < ApplicationController
    
    layout "standard"
    
    include Geokit::IpGeocodeLookup
    geocode_ip_address
   
    def index
        
        session[:geo_location] = Geokit::Geocoders::GoogleGeocoder.geocode('450 Lexington Avenue, New York, NY 10017') if not session[:geo_location]
        
        loc = session[:geo_location]
                
        close = Restaurant.find_within(CLOSE, :origin => loc, :conditions => {:closed => 0})
        near  = Restaurant.find_within(NEAR, :origin => loc, :conditions => {:closed => 0})
        far   = Restaurant.find_within(FAR, :origin => loc, :conditions => {:closed => 0})
        
        near -= close
        far  -= near
        
        # remove name matches
        near.delete_if { |n| close.map{|c|c.name}.include? n.name }
        far.delete_if { |f| close.map{|c|c.name}.include? f.name }
        far.delete_if { |f| near.map{|n|n.name}.include? f.name }
        
        puts close.size
        puts near.size
        puts far.size
        
        @close = close[ActiveSupport::SecureRandom.random_number(close.size)]
        @near  = near[ActiveSupport::SecureRandom.random_number(near.size)]
        @far   = far[ActiveSupport::SecureRandom.random_number(far.size)]
        
        @close_map = create_map(@close, loc, "close_map", 17)
        @near_map = create_map(@near, loc, "near_map", 16)
        @far_map = create_map(@far, loc, "far_map", 15)
    end
    
    def create_map(loc, origin, div_name, zoom)        
        map = Map.new(div_name, zoom)
        map.route(Marker.new(origin, :label => "You!", :info_bubble => "You!"),
                  Marker.new(loc, :label => loc.name, :info_bubble => (loc.name + "\n" + loc.get_address).gsub("\n", "<br/>")))
        map
    end
    
end