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
    end
  
    def edit
      @discussion = Discussion.find(params[:id])
      @target = @discussion.target
    end
  
    def create
      @target = find_target
      @discussion = @target.discussions.build(params[:discussion])
      @discussion.user_id  = current_user.id
  
      respond_to do |format|
        if @discussion.save
          generate_post(current_user.id, @discussion, @discussion.title, "started_discussion", true)
          format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
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
        if @discussion.update_attributes(params[:discussion])
          format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
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
  
      respond_to do |format|
        format.html { redirect_to discussions_url }
        format.json { head :no_content }
      end
    end
  end
end
