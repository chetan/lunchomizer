
CLOSE = 0.1
NEAR  = 0.25
FAR   = 0.45

require 'gmap'
include GMap

ADDRESS = 1
IP = 2
HTML5 = 3

class LunchController < ApplicationController

    include Geokit::IpGeocodeLookup

    def index

        @trygeo = true

        # try to get lat/lng using one of these methods
        if params[:address] and not params[:address].strip.empty? then
            # use given address
            addy = params[:address].strip
            if addy !~ /,/ and addy !~ /^\d+$/ then
                addy += ", New York, NY"
            end
            session[:source] = ADDRESS
            session[:address] = addy
            session[:geo_location] = Geokit::Geocoders::GoogleGeocoder.geocode(addy)
            return redirect_to root_url() # do a redirect for easy reloading

        elsif params[:lat] and not params[:lat].strip.empty? then
            session[:source] = HTML5
            session[:geo_location] = Geokit::LatLng.new(params[:lat], params[:lng])
            rev = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(session[:geo_location])
            session[:address] = rev.full_address if rev

        elsif not session[:geo_location] then
            # init from IP
            session[:source] = IP
            store_ip_location
            if session[:geo_location] then
                rev = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(session[:geo_location])
                session[:address] = rev.full_address if rev
            end

        end

        @source = session[:source]
        @address = session[:address]
        loc = session[:geo_location]

        if @source == ADDRESS or @source == HTML5 then
            # if we used either of these 2 sources, no more need to do automatically do a HTML5 lookup
            @trygeo = false
        end

        #session[:geo_location] = Geokit::Geocoders::GoogleGeocoder.geocode('450 Lexington Avenue, New York, NY 10017')

        # p loc
        return if not loc

        close = Restaurant.within(CLOSE, :origin => loc, :conditions => {:closed => 0})
        near  = Restaurant.within(NEAR, :origin => loc, :conditions => {:closed => 0})
        far   = Restaurant.within(FAR, :origin => loc, :conditions => {:closed => 0})

        near -= close
        far  -= near

        # remove name matches
        near.delete_if { |n| close.map{|c|c.name}.include? n.name }
        far.delete_if { |f| close.map{|c|c.name}.include? f.name }
        far.delete_if { |f| near.map{|n|n.name}.include? f.name }

        # random picks
        @close = close[ActiveSupport::SecureRandom.random_number(close.size)]
        @near  = near[ActiveSupport::SecureRandom.random_number(near.size)]
        @far   = far[ActiveSupport::SecureRandom.random_number(far.size)]

        # create maps
        @close_map = create_map(@close, loc, "close_map", 17) if @close
        @near_map = create_map(@near, loc, "near_map", 16) if @near
        @far_map = create_map(@far, loc, "far_map", 15) if @far
    end

    def create_map(loc, origin, div_name, zoom)
        map = Map.new(div_name, zoom)
        map.route(Marker.new(origin, :label => "You!", :info_bubble => "You!"),
                  Marker.new(loc, :label => loc.name, :info_bubble => (loc.name + "\n" + loc.get_address).gsub("\n", "<br/>")))
        map
    end

end
