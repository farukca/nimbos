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
	    @comment = @commentable.comments.build(comment_params)
	    @comment.user_id  = current_user.id
	    #group_id = @commentable.group.id if @commentable.group

	    @comment.save!
	    #generate_notification('commented', @commentable.to_s, @commentable, nil, nil)
	    #generate_post(current_user.id, @comment, @commentable.title, "commented", true)
	    respond_with @comment, notice: t("simple_form.messages.defaults.commented")
	  end

	  def destroy
	    @comment = Nimbos::Comment.find(params[:id])
	    @comment.destroy
	    flash[:notice] = t("simple_form.messages.defaults.deleted", model: Nimbos::Comment.model_name.human)
	    redirect_to comments_url
	  end

	  private
	  def comment_params
	  	params.require(:comment).permit(:comment_text, :commenter, :commentable, :user_id)
	  end

  end
end
