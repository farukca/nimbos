module Nimbos::Concerns::GenerateActivity

	extend ActiveSupport::Concern

	included do
		after_create  :generate_activity
	end

  def generate_activity
    Nimbos::Activity.log(user_id, self, branch_id)
  end

end