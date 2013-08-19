require_dependency "nimbos/application_controller"

module Nimbos
  class SessionsController < ApplicationController

    def new
    	@user = User.new
    	@user.email = cookies[:socialfreight_mail].to_s
    end

    def create
			if warden.authenticate(:scope => :user)
				force_authentication!(current_patron, current_user)
				unless session[:return_to_url].blank?
					redirect_to session[:return_to_url]
					session[:return_to_url] = nil
				else
					flash[:notice] = "You are now signed in."
				  redirect_to root_path
				end
			else
				flash[:error] = "Invalid email or password."
				@user = User.new
				@user.email = params["user"]["email"]
				render :action => "new"
			end
		end

    def destroy
      warden.logout
      redirect_to root_url, notice: "Logged out!"
    end
  end
end
