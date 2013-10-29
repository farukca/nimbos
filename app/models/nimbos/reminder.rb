module Nimbos
  class Reminder < ActiveRecord::Base

    belongs_to :remindfor, polymorphic: true, counter_cache: true
	  belongs_to :user
  
  	default_scope { where(patron_id: Nimbos::Patron.current_id) }
  end
end
