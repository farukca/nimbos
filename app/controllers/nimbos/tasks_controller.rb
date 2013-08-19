require_dependency "nimbos/application_controller"

module Nimbos
  class TasksController < ApplicationController
	  before_filter :require_login
	  respond_to :js, :json

	  def index
	  	@tasks = current_user.tasks
	  end

	  def new
	    @todolist = Nimbos::Todolist.find(params[:todolist_id])
	    @task = @todolist.tasks.new
	  end

	  def show
	  	@task = Nimbos::Task.find(params[:id])
	    @todolist = @task.todolist
	  end

	  def edit
	  	@task = Nimbos::Task.find(params[:id])
	    @todolist = @task.todolist
	  end

	  def create
	    @todolist = Nimbos::Todolist.find(params[:todolist_id])

	  	@task = @todolist.tasks.new(params[:task])
	  	@task.cruser_id = current_user.id
	    @task.user_id   = 0

	    @task.save!
	    respond_with @task, success: "Successfully saved task"
	  end

	  def update
	  	@task = Nimbos::Task.find(params[:id])
	    @todolist = @task.todolist

	    @task.update_attributes!(params[:task])
	    respond_with @task, success: 'task was successfully updated.'
	  end

	  def destroy
	  end
  end
end
