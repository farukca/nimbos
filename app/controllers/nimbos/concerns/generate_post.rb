module Nimbos::Concerns::GeneratePost
  extend ActiveSupport::Concern

  def generate_post(user_id, object, object_name, action_type, syspost_flag)
    Nimbos::Post.create_post(user_id, object, object_name, action_type, syspost_flag)
  end

end