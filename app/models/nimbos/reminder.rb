module Nimbos
  class Reminder < ActiveRecord::Base

    belongs_to :remindfor, polymorphic: true, counter_cache: true
	  belongs_to :user
  
  	validates :title, presence: true, length: { maximum: 255 }
  	validates :start_date, presence: true
  	
  	default_scope { where(patron_id: Nimbos::Patron.current_id) }
  end
end
