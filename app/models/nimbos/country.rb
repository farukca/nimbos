module Nimbos
  class Country < ActiveRecord::Base
	  set_primary_key = 'code'
	  #include Gmaps4rails::ActsAsGmappable
	 
	  #acts_as_gmappable :process_geocoding => false, :validation => false
	  
	  attr_accessible :name, :code, :telcode, :locale, :language, :time_zone, :mail_encoding
	  
	  validates_presence_of :name, :code
	  validates_uniqueness_of :name, :case_sensitive => false
	  validates_uniqueness_of :code, :case_sensitive => false
	  validates_length_of   :code, :maximum => 2
	  validates_length_of   :name, :maximum => 100

	  default_scope { where(listable: true) }

	  #before_save :get_coordinates

	  #def gmaps4rails_address
	  #  self.name
	  #end

	  #def get_coordinates
	  #  self.location = Gmaps4rails.geocode(gmaps4rails_address).first
	  #end

	  def token_inputs
	     { :id => _id, :name => name }
	  end

	  def to_s
	  	"#{name}-#{telcode}"
	  end

	  def to_param
	  	"#{id}-#{name.parameterize}"
	  end

  end
end
