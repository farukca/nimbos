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
	    respond_with @task, notice: t("simple_form.messages.defaults.created", model: Nimbos::Task.model_name.human)
	  end

	  def update
	  	@task = Nimbos::Task.find(params[:id])
	    @todolist = @task.todolist

	    if params[:task][:status] == "closed"
	    	@task.closed_date = Time.zone.today
	    	@task.user_id     = current_user.id
	    else
	    	@task.closed_date = nil
	    end

	    @task.update_attributes!(task_params)
	    respond_with @task, notice: t("simple_form.messages.defaults.updated", model: Nimbos::Task.model_name.human)
	  end

	  def destroy
	  	@task = Task.find(params[:id])
	  	@todolist = @task.todolist
      @task.destroy

      respond_to do |format|
        format.html { redirect_to @todolist, notice: t("simple_form.messages.defaults.deleted", model: Nimbos::Task.model_name.human) }
        format.json { head :ok }
        format.js { flash.now[:notice] = t("simple_form.messages.defaults.deleted", model: Nimbos::Task.model_name.human) }
      end
	  end

	  private
	  def task_params
	  	params.require(:task).permit(:user_id, :task_text, :task_code, :due_date, :status, :close_text, :closed_date, :system_task)
	  end
  end
end
