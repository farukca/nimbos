module Nimbos
  class UserMailer < ActionMailer::Base
    default from: Rails.application.secrets.contact_mail
  
    def activation_needed_email(user_id)
      @user = User.find(user_id)
      @url  = "http://#{Rails.application.secrets.root_url}/users/#{@user.activation_token}/activate"
      @app_name = Rails.application.secrets.app_name
      mail :to => @user.email, :subject => "#{@app_name} Account Activation"
    end

    def activation_success_email(user_id)
      @user = User.find(user_id)
      @url  = "http://#{Rails.application.secrets.root_url}/login"
      @app_name = Rails.application.secrets.app_name
      mail :to => @user.email, :subject => "Welcome to #{@app_name}"
    end

    def password_reset_email(user_id)
      @user = User.find(user_id)
      @url  = "http://#{Rails.application.secrets.root_url}/password_resets/#{@user.password_reset_token}/edit"
      @app_name = Rails.application.secrets.app_name
      @contact_mail = Rails.application.secrets.contact_mail
      mail :to => @user.email, :subject => "#{@app_name} Password Reset"
    end
  end
end
