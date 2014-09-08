module Nimbos::Concerns::Trashable

	extend ActiveSupport::Concern

	included do
		default_scope { where(trashed: false) }
	end

	def trash(user_id)
    run_callbacks :destroy do
    	update_attribute :trashed, true
    	Arsiv::Junk.send_to_junk(user_id, self, self.to_s, nil)
    end
  end

  def recover
  	update_attribute :trashed, false
  end
  
end