
module GMap
    
    class Marker
        
        attr_accessor :lat, :lng, :address, :zip, :label, :bubble
        
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
                @zip = point.zip if point.respond_to? :zip
                
            else
                raise "Invalid Lat & Long type"
            end
            
        end
        
        def to_js
            if @address and not @address.empty? then
                "\"#{@address}, #{@zip}\""
            else
                to_latlng()
            end
        end
        
        def to_latlng
            "new google.maps.LatLng(#{@lat}, #{@lng})"
        end
        
        def marker_js(map, pos)
            js = <<-EOF
               
var contentString = "#{@bubble}";
var infowindow = new google.maps.InfoWindow({ content: contentString });

var marker = new google.maps.Marker({
    position: #{pos},
    map: #{map},
    title: "#{@label}"
});

google.maps.event.addListener(marker, 'click', function() {
  infowindow.open(#{map}, marker);
});

EOF
            
        end
        
    end
    
end
