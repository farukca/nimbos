module Nimbos::Concerns::GenerateGroup

	extend ActiveSupport::Concern

	included do
		attr_accessor :group_user_ids

		after_create  :generate_group, :notify_group_users
	end

  def generate_group
    Nimbos::Group.add_group(self.user_id, self, self.group_user_ids)
  end

  def notify_group_users
  	Messenger::Notification.notify_users(self.user_id, "created_", self.to_s, self, self.group_user_ids)
  end

end