
class Restaurant < ActiveRecord::Base
    
	acts_as_mappable
	
	def is_cart?
	    self.categories =~ /Carts/
    end
    
    def get_address(xstreet_always = false)
        if self.address.empty? then
            if self.is_cart? then
                "Cart, " + self.xstreet
            elsif not self.xstreet.empty?
                self.xstreet
            else
                "n/a"
            end
        else
            r = self.address
            r += "\n" + self.xstreet if xstreet_always
            r
        end
    end
end