require_dependency "nimbos/application_controller"

module Nimbos
  class SetupController < ApplicationController
	  include Wicked::Wizard

	  before_filter :require_login
	  #layout "admin"
	  steps :start_wizard, :set_address, :set_branches, :set_users#, :set_codes, :set_params, 
	  
	  def show
	    @patron = current_patron
	    @user   = current_user
	    case step
	      when :set_params
	        #counter_size = @patron.counters.size
	        #if counter_size == 0
	        @operation = params[:operation]
	        if params[:operation].present?
	          counter = @patron.counters.find_or_initialize_by(operation: params[:operation], counter_type: "Loading")
	          counter = @patron.counters.find_or_initialize_by(operation: params[:operation], counter_type: "Position")
	        else      
	          ["air","sea","road","rail"].each { |o|
	            counter = @patron.counters.find_or_initialize_by(operation: o, counter_type: "Loading")
	            counter = @patron.counters.find_or_initialize_by(operation: o, counter_type: "Position")
	          }
	        end
	      when :set_users
	        @users = Array.new(7) { Nimbos::User.new }
	    end
	    render_wizard
	      
	  end
	  
	  def update
	    @patron = current_patron
	    case step
	      when :set_users
	        params[:patron][:users_attributes].each do |key, user|
	          user[:password] = "987654321"
	          user[:password_confirmation] = "987654321"
	        end if params[:patron][:users_attributes]
	    end
	    @patron.update_attributes(params[:patron])

	    render_wizard @patron
	  end
  end
end
