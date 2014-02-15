require_dependency "nimbos/application_controller"

module Nimbos
  class DiscussionsController < ApplicationController
    include Nimbos::Concerns::GeneratePost
    include Nimbos::Concerns::FindTarget

    before_filter :require_login
    respond_to :js, :json, :html

    def index
      @discussions = Discussion.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @discussions }
      end
    end
  
    def show
      @discussion = Discussion.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @discussion }
      end
    end
  
    def new
      @target = find_target
      @discussion = @target.discussions.new
      @discussion.target_name = @target.to_s
    end
  
    def edit
      @discussion = Discussion.find(params[:id])
      @target = @discussion.target
    end
  
    def create
      #@target = find_target
      @discussion = Discussion.new(discussion_params)
      @discussion.user_id  = current_user.id
  
      respond_to do |format|
        if @discussion.save
          #engine = @target.class.name.split("::").first.downcase
          #generate_post(current_user.id, "started_discussion", @discussion, @discussion.title, nimbos.discussion_url(@discussion), @target, @target.to_s, polymorphic_url([send(engine), @target]), "started_discussion", engine, false, true)
          format.html { redirect_to @discussion, notice: t("discussions.message.created") }
          format.json { render json: @discussion, status: :created, location: @discussion }
        else
          format.html { render action: "new" }
          format.json { render json: @discussion.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      @discussion = Discussion.find(params[:id])
  
      respond_to do |format|
        if @discussion.update_attributes(discussion_params)
          format.html { redirect_to @discussion, notice: t("discussions.message.updated") }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @discussion.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @discussion = Discussion.find(params[:id])
      @discussion.destroy
      flash[:notice] = t("discussions.message.deleted")
  
      respond_to do |format|
        format.html { redirect_to discussions_url }
        format.json { head :no_content }
      end
    end

    private
    def discussion_params
      params.require(:discussion).permit(:title, :content, :target_id, :target_type)
    end
  end
end
