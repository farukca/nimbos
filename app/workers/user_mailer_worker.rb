class UserMailerWorker
	
  @queue = :user_mailer_queue

  def self.perform(options={})

  	user = Nimbos::User.find(options["user_id"])

  	case options["mail_type"]
			when "activation_needed"
    		Nimbos::UserMailer.activation_needed_email(user).deliver
			when "activation_success"
			  Nimbos::UserMailer.activation_success_email(user).deliver
			when "password_reset"
			  Nimbos::UserMailer.password_reset_email(user).deliver
		end

  end

end
