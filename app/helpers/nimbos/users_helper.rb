module Nimbos
  module UsersHelper
	  def user_name(user = @user)
	  	user.name
	  end

	  def first_name(user = @user)
	    user.name
	  end

	  def user_small_avatar(user = @user)
	    #user.avatar_url(:small)
	    cl_image_tag(user.avatar_url, width: 48, height: 48, crop: :fill, class: "img-circle")
	  end

	  def user_mini_avatar(user = @user)
	    #user.avatar_url(:mini)
	    cl_image_tag(user.avatar_url, width: 30, height: 30, crop: :fill)
	  end

	  def user_avatar(user = @user)
	    #user.avatar_url(:mini)
	    cl_image_tag(user.avatar_url, width: 180, height: 180, crop: :fill, class: "img-responsive")
	  end

	  def users_active_tasks_count(user = @user)
	    user.tasks.active.count
	  end

	  def users_unread_notifications_count(user = @user)
	    #user.mentioners(Post).count
	    0
	  end

	  def users_unread_messages_count(user = @user)
	  	0
	  end

	  def user_picture_tag(user=@user)
	    link_to (image_tag user.avatar_url(:small), class: "img-circle"), user_path(user), title: user_name(user)
	  end
  end
end
