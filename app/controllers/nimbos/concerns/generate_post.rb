module Nimbos::Concerns::GeneratePost
  extend ActiveSupport::Concern

  def generate_post(user_id, message, object, object_title, object_url, parent, parent_title, parent_url, action_type, channel, private_flag, syspost_flag)
    Nimbos::Post.create_post(user_id, message, object, object_title, object_url, parent, parent_title, parent_url, action_type, channel, private_flag, syspost_flag)
  end

end