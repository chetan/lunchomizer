
class LunchController < ApplicationController
    
    include Geokit::IpGeocodeLookup
   
    def index
        puts session[:geo_location]
    end
    
end