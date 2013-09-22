require_dependency "nimbos/application_controller"

module Nimbos
  class CommentsController < ApplicationController
  	include Nimbos::Concerns::GeneratePost
   	include Nimbos::Concerns::FindTarget

	  before_filter :require_login
	  respond_to :js, :json

	  def new
	    @commentable = find_target
	    @comment = @commentable.comments.new
	    @comment.commentable_type = @commentable.class.name
	    @comment.commentable_id = @commentable.id
	  end

	  def create
	    @commentable = find_target
	    @comment = @commentable.comments.build(params[:comment])
	    @comment.user_id  = current_user.id

	    @comment.save!
	    #generate_post(current_user.id, @comment, @commentable.title, "commented", true)
	    respond_with @comment, :success => "Comment added"
	  end

	  def destroy
	    @comment = Nimbos::Comment.find(params[:id])
	    @comment.destroy
	    flash[:notice] = "Successfully destroyed comment."
	    redirect_to comments_url
	  end

  end
end
