
class Restaurant < ActiveRecord::Base
    
	acts_as_mappable
	
	def is_cart?
	    self.categories =~ /Carts/
    end
end