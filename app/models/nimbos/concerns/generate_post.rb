module Nimbos::Concerns::GeneratePost

	extend ActiveSupport::Concern

	included do
		after_create  :generate_post
	end

  def generate_post
    Nimbos::Post.log(user_id, self, self.to_s, "created", true)
  end

end