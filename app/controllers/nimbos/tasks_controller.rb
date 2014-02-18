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

	  	@task = @todolist.tasks.new(task_params)
	  	@task.cruser_id = current_user.id
	    @task.user_id   = 0

	    @task.save!
	    respond_with @task, notice: t("tasks.message.created")
	  end

	  def update
	  	@task = Nimbos::Task.find(params[:id])
	    @todolist = @task.todolist

	    @task.update_attributes!(task_params)
	    respond_with @task, notice: t("tasks.message.updated")
	  end

	  def destroy
	  end

	  private
	  def task_params
	  	params.require(:task).permit(:user_id, :task_text, :task_code, :due_date, :status, :close_text, :closed_date, :system_task)
	  end
  end
end
