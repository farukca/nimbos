require_dependency "nimbos/application_controller"

module Nimbos
  class TodolistsController < ApplicationController
	  before_filter :require_login
	  respond_to :html, :js, :json

	  def new
	    @todop = find_todop
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

	  private
	  def find_todop
	    params.each do |name, value|
	      if name =~ /(.+)_id$/
	        return $1.classify.constantize.find(value)
	      end
	    end
	    nil
	  end
  end
end
