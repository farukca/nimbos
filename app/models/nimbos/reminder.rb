module Nimbos
  class Reminder < ActiveRecord::Base

    belongs_to :remindfor, polymorphic: true, counter_cache: true
	  belongs_to :user
  
  	attr_accessible :description, :finish_date, :start_date, :start_hour, :title, :user_id,
    	              :calendar_scope, :remindfor_type, :remindfor_id

  	default_scope { where(patron_id: Nimbos::Patron.current_id) }
  end
end
