
module GMap
    
    class Map
        
        attr_accessor :name, :zoom, :origin, :dest
       
        def initialize(name, zoom)
            @name = name
            @zoom = zoom
        end
        
        def route(from, to)
            @origin = from
            @dest = to
        end
        
        def recenter_html
           "google.maps.event.trigger(#{@name}, 'resize'); #{@name}.panTo(#{@origin.to_js}); #{@name}.setZoom(#{@zoom});"
        end
        
        def header_html
            html = <<-EOF
<script type="text/javascript">
var #{@name};
window.onload = addCodeToFunction(window.onload,function() {
    
    var origin = #{@origin.to_js};
    var dest = #{@dest.to_js};
    
    var mapOpts = {
      zoom:16,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      center: origin
    }
    #{@name} = new google.maps.Map(document.getElementById("#{@name}"), mapOpts);
    
    
    var directionsService = new google.maps.DirectionsService();
    var directionsDisplay = new google.maps.DirectionsRenderer();

    directionsDisplay.setMap(#{@name});

    var request = {
        origin: origin,
        destination: dest,
        travelMode: google.maps.DirectionsTravelMode.WALKING
    };
    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
        
        #{@origin.marker_js(@name, "response.routes[0].legs[0].start_location")}
        #{@dest.marker_js(@name, "response.routes[0].legs[0].end_location")}
      }
    });

});
</script>

EOF
        end
        
    end
    
end