module Nimbos
  class Currency < ActiveRecord::Base
    set_primary_key = 'code'
    
    #attr_accessible :code, :multiplier, :name, :symbol

    validates_presence_of :code
	  validates_presence_of :name
	  validates_uniqueness_of :code, :case_sensitive => false
	  validates_uniqueness_of :name, :case_sensitive => false

	  scope :nameOrdered, order("name")
  end
end
