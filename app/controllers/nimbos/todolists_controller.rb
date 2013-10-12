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
	    @todolist = Nimbos::Todolist.new(params[:todolist])
	    @todolist.user_id  = current_user.id
	    @todolist.save!
	    respond_with @todolist, success: "Successfully saved todolist"
	  end

	  def show
	    @todolist = Nimbos::Todolist.find(params[:id])
	  end

  end
end
