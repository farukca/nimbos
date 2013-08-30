require_dependency "nimbos/application_controller"

module Nimbos
  class PasswordResetsController < ApplicationController
	  skip_before_filter :require_login

	  def new
	  end

	  def create
	    @user = Nimbos::User.find_by_email(params[:email])
	    if @user
		    @user.deliver_password_reset_token
	  	  redirect_to main_app.root_path, :notice => "Email Sent with password reset instructions"
	  	else
				flash[:error] = "Invalid email, check your email address."
				render :action => "new"
	  	end
	  end

	  def edit
	    @user = Nimbos::User.load_from_password_reset_token(params[:id])
	    @token = params[:id]
	    not_authenticated unless @user
	  end

	  def update
	    @token = params[:token]
	    @user  = Nimbos::User.load_from_password_reset_token(params[:token])
	    not_authenticated unless @user

	    @user.password_confirmation = params[:user][:password_confirmation]
	    
	    if @user.change_password!(params[:user][:password])
	      redirect_to(main_app.root_path, :notice => 'Your password has been changed')
	    else
	      render :action => :edit
	    end
	  end
  end
end
