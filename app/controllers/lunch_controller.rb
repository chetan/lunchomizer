
class LunchController < ApplicationController
    
    include Geokit::IpGeocodeLookup
   
    def index
        session[:geo_location] = Geokit::Geocoders::GoogleGeocoder.geocode('450 Lexington Avenue, New York, NY 10017') if not session[:geo_location]
        # p session[:geo_location]
        
        if session[:geo_location] then
            
            srand Time.new.to_i
            
            near = Restaurant.find_within(0.1, :origin => session[:geo_location], :conditions => {:closed => 0})
            near = near[rand(near.size)]
            p near
        end
    end
    
end