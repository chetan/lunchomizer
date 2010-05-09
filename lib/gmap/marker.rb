
module GMap
    
    class Marker
        
        attr_accessor :lat, :lng, :label, :bubble
        
        def initialize(point, options = {})
            
            @label = options[:label]
            @bubble = options[:bubble]
            
            if point.kind_of? Array then
                @lat = point[0]
                @lng = point[1]
                
            elsif point.respond_to(:lat) and point.respond_to(:lng) then
                @lat = point.lat
                @lng = point.lng
            else
                raise "Invalid Lat & Long type"
            end
            
        end
        
        def to_js
            "new google.maps.LatLng(#{@lat}, #{@lng})"
        end
        
    end
    
end
