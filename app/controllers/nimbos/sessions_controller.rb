require_dependency "nimbos/application_controller"

module Nimbos
  class SessionsController < ApplicationController

    def new
    	@user = User.new
    	@user.email = cookies[:socialfreight_mail].to_s
    	render :layout => "register"
    end

    def create
    	current_time = Time.now
			if warden.authenticate(:scope => :user)
				force_authentication!(current_patron, current_user)
				flash.discard(:error)
				if current_user.user_status != "active"
					flash[:error] = "Your account has been closed, if you think there is an error, please send a mail to hello@modaltrans.com"
          warden.logout
				  @user = User.new
			  	render :action => "new"
				else
          current_user.update(last_login_at: current_time)
					unless session[:return_to_url].blank?
						redirect_to session[:return_to_url]
						session[:return_to_url] = nil
					else
						#flash[:notice] = "You are now signed in."
					  redirect_to main_app.root_path
					end
				end
			else
				@user = Nimbos::User.find_by(email: params[:user][:email])
				if @user && (@user.activation_state != "active")
					flash[:error] = "Your account has not been approved, please check your mail."
				else
				  flash[:error] = "Invalid email or password."
				end
				@user = User.new
				@user.email = params["user"]["email"]
				render :action => "new"
			end
		end

    def destroy
      warden.logout
      redirect_to main_app.root_url#, notice: "Logged out!"
    end
  end
end
