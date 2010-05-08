
CLOSE = 0.1
NEAR  = 0.25
FAR   = 0.45

class LunchController < ApplicationController
    
    layout "standard"
    
    include Geokit::IpGeocodeLookup
    geocode_ip_address
   
    def index
        
        session[:geo_location] = Geokit::Geocoders::GoogleGeocoder.geocode('450 Lexington Avenue, New York, NY 10017') if not session[:geo_location]
        # p session[:geo_location]
        
        loc = session[:geo_location]
        srand Time.new.to_i
                
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
        
        @close = close[rand(close.size)]
        @near  = near[rand(near.size)]
        @far   = far[rand(far.size)]

    end
    
end