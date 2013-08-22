require_dependency "nimbos/application_controller"

module Nimbos
  class ActivitiesController < ApplicationController
    def show
    	@activity = Nimbos::Activity.find(params[:id])
  	  redirect_to @activity.target
    end
  end
end
