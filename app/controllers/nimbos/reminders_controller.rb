require_dependency "nimbos/application_controller"

module Nimbos
  class RemindersController < ApplicationController
	  def index
	    @reminders = current_user.reminders.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json #{ render json: @reminders }
	    end
	  end

	  def show
	    @reminder = Nimbos::Reminder.find(params[:id])

	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @reminder }
	    end
	  end

	  def new
	    @reminder = Nimbos::Reminder.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @reminder }
	    end
	  end

	  def edit
	    @reminder = Nimbos::Reminder.find(params[:id])
	  end

	  def create
	    @reminder = Nimbos::Reminder.new(reminder_params)
	    @reminder.user_id = current_user.id

	    respond_to do |format|
	      if @reminder.save
	        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
	        format.json { render json: @reminder, status: :created, location: @reminder }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @reminder.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    @reminder = Nimbos::Reminder.find(params[:id])

	    respond_to do |format|
	      if @reminder.update_attributes(reminder_params)
	        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @reminder.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def destroy
	    @reminder = Nimbos::Reminder.find(params[:id])
	    @reminder.destroy

	    respond_to do |format|
	      format.html { redirect_to reminders_url }
	      format.json { head :no_content }
	    end
	  end

	  private
	  def reminder_params
	  	params.require(:reminder).permit(:description, :finish_date, :start_date, :start_hour, :title, :user_id, :calendar_scope, :remindfor_type, :remindfor_id)
	  end
  end
end
