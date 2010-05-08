# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
    def get_address(r)
        if r.address.empty? then
            if r.is_cart? then
                "Cart, " + r.xstreet
            elsif not r.xstreet.empty?
                r.xstreet
            else
                "n/a"
            end
        else
            r.address
        end
    end
    
end
