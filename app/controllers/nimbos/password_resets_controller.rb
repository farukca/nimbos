require_dependency "nimbos/application_controller"

module Nimbos
  class PasswordResetsController < ApplicationController
	  skip_before_filter :require_login

	  def new
	  	render :layout => "register"
	  end

	  def create
	    @user = Nimbos::User.find_by_email(params[:email])
	    if @user
		    @user.deliver_password_reset_token
	  	  redirect_to main_app.root_path, notice: t("users.messages.send_pasword_reset_instructions")
	  	else
				flash[:error] = t("users.messages.invalid_email")
				render :action => "new"
	  	end
	  end

	  def edit
	    @user = Nimbos::User.load_from_password_reset_token(params[:id])
	    @user.token = params[:id]
	    not_authenticated unless @user
	    render :layout => "register"
	  end

	  def update
	    @user  = Nimbos::User.load_from_password_reset_token(params[:user][:token])
	    not_authenticated unless @user

	    if @user
	    	@user.token = params[:user][:token]
	    	@user.password_confirmation = params[:user][:password_confirmation]
		    if @user.change_password(params[:user][:password])
		      redirect_to main_app.root_path, notice: t("users.messages.password_changed")
		    else
		      render :action => :edit
		    end
		  else
		  	render :action => :edit
		  end
	  end
  end
end
