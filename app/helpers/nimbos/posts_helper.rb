module Nimbos
  module PostsHelper

  	def post_title(post=@post)
  		case post.target_type
				when "Nimbos::Comment"
				  "#{user_name(post.user)} commented on #{post.target_title}"
				when nil
				  "#{user_name(post.user)}"
				else
					if post.is_syspost
				    "#{user_name(post.user)} #{post.message} #{post.target_type}: #{post.target_title}"
				  else
				  	"#{user_name(post.user)}  commented on: #{post.target_title}"
				  end
			end
  	end

  	def post_target_icon(post=@post)
  		if post.target_type != "Nimbos::Comment"
  			image_tag("position.png", :height => "32", :width => "32")
  		else
        user_mini_avatar(post.target.user)
  		end
  	end

  	def post_target_name(post=@post)
      post.target_title
  	end

  end
end
