require_dependency "nimbos/application_controller"

module Nimbos
  class TodolistsController < ApplicationController
    include Nimbos::Concerns::FindTarget

	  before_filter :require_login
	  respond_to :html, :js, :json

	  def new
	    @todop = find_target
	    if @todop
	      @todolist = @todop.todolists.new
	    else
	      @todolist = Nimbos::Todolist.new
	    end
	    @todolist.tasks.build()
	  end

	  def create
	    @todolist = Nimbos::Todolist.new(todolist_params)
	    @todolist.user_id  = current_user.id
	    @todolist.save!
	    respond_with @todolist, notice: t("simple_form.messages.defaults.created", model: Nimbos::Todolist.model_name.human)
	  end

	  def show
	    @todolist = Nimbos::Todolist.find(params[:id])
	  end

    private
    def todolist_params
    	params.require(:todolist).permit(:name, :user_id, :todop_type, :todop_id, :tasks_attributes)
    end
  end
end
