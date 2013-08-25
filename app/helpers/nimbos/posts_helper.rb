module Nimbos
  module PostsHelper

  	def post_title(post=@post)
  		case post.target_type
				when "Nimbos::Post"
				  "#{user_name(post.user)} commented on:"
				when nil
				  "#{user_name(post.user)}"
				else
				  "#{user_name(post.user)} #{post.message} #{post.target_type}: #{post.target_name}"
			end
  	end

  end
end
