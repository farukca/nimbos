module Nimbos
  class Branch < ActiveRecord::Base
	  #acts_as_gmappable :process_geocoding => false, :validation => false

	  belongs_to :patron	  
	  belongs_to :country

	  validates :name, presence: true, length: { maximum: 100}

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }

    def to_s
    	name
    end

    def to_param
    	"#{id}-#{name.parameterize}"
    end

	  #def gmaps4rails_address
	  #  "#{self.address}, #{self.district}, #{self.city.name if self.city}, #{self.country.name if self.country}" 
	  #end
	  
	  #def prevent_geocoding
	  #  self.address.blank? #|| (!self.location.blank?)
	  #end
  end
end
