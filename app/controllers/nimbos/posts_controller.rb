require_dependency "nimbos/application_controller"

module Nimbos
  class PostsController < ApplicationController
    include Nimbos::Concerns::FindTarget

	  before_filter :require_login
	  before_filter(:only => [:index]) { |c| c.set_tab "postnavigator" }
	  respond_to :js, :json, :html

	  def show
	    @post = Nimbos::Post.find(params[:id])
	  end

	  def create
	    @target = find_target
	    if @target
	      @post = @target.posts.build(post_params)
	      @post.target_name = @target.to_s[0, 40]
	    else
	      @post = Nimbos::Post.new(post_params)
	    end
	    @post.user_id  = current_user.id
	#TODO daha sonra bakmak üzere şimdilik kapatalım mention olayını
	    #usernames = extract_mentioned_screen_names(post_params[:message]) if post_params[:message]
	    #usernames.each do |username|
	    #  @object = Nick.find_by_name(username)
	    #  @post.mention!(@object.nicknamed) unless @object.nil?
	    #end if usernames
	    @post.save!
	    respond_with @post, success: "Successfully saved post"
	  end

	  def destroy
	    @post = Nimbos::Post.find(params[:id])
	    @post.destroy
	    respond_with @post, notice: "Successfully destroyed post"
	  end

  end

  private
  def post_params
  	params.require(:post).permit(:message, :is_private, :related_user_ids, :target, :user_id, :target_title, :is_syspost)
  end
end
