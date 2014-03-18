module Nimbos
  class UserMailer < ActionMailer::Base
    default from: Global.settings.contact_mail
  
    def activation_needed_email(user_id)
      @user = User.find(user_id)
      @url  = "http://#{Global.settings.root_url}/users/#{@user.activation_token}/activate"
      @app_name = Global.settings.app_name
      mail :to => @user.email, :subject => "#{@app_name} Account Activation"
    end

    def activation_success_email(user_id)
      @user = User.find(user_id)
      @url  = "http://#{Global.settings.root_url}/login"
      @app_name = Global.settings.app_name
      mail :to => @user.email, :subject => "Welcome to #{@app_name}"
    end

    def password_reset_email(user_id)
      @user = User.find(user_id)
      @url  = "http://#{Global.settings.root_url}/password_resets/#{@user.password_reset_token}/edit"
      @app_name = Global.settings.app_name
      @contact_mail = Global.settings.contact_mail
      mail :to => @user.email, :subject => "#{@app_name} Password Reset"
    end
  end
end
