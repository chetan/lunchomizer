
module GMap
    
    class Marker
        
        attr_accessor :lat, :lng, :address, :label, :bubble
        
        def initialize(point, options = {})
            
            @label = options[:label]
            @bubble = options[:bubble]
            
            if point.kind_of? Array then
                @lat = point[0]
                @lng = point[1]
                
            elsif point.respond_to? :lat and point.respond_to? :lng then
                @lat = point.lat
                @lng = point.lng
                @address = point.address if point.respond_to? :address
                
            else
                raise "Invalid Lat & Long type"
            end
            
        end
        
        def to_js
            if @address and not @address.empty? then
                "\"#{@address}\""
            else
                "new google.maps.LatLng(#{@lat}, #{@lng})"
            end
        end
        
    end
    
end
