module Nimbos
  class UserMailer < ActionMailer::Base
    default from: "hello@modaltrans.com"
  
    def activation_needed_email(user_id)
      @user = User.find(user_id)
      @url  = "http://www.socialfreight.com/users/#{@user.activation_token}/activate"
      mail :to => @user.email, :subject => "SocialFreight Account Activation"
    end

    def activation_success_email(user_id)
      @user = User.find(user_id)
      @url  = "http://www.socialfreight.com/login"
      mail :to => @user.email, :subject => "Welcome to SocialFreight"
    end

    def password_reset_email(user_id)
      @user = User.find(user_id)
      @url  = "http://www.socialfreight.com/password_resets/#{@user.password_reset_token}/edit"
      mail :to => @user.email, :subject => "SocialFreight Password Reset"
    end
  end
end
