module Nimbos::Concerns::Authentication

	extend ActiveSupport::Concern

	included do
		has_secure_password

		before_create :setup_activation
		after_create  :send_activation_mail!
	end

  module ClassMethods

    def load_from_activation_token(token)
      return nil if token.blank?
      where("activation_token = ?", token).first
    end

    def load_from_password_reset_token(token)
      return nil if token.blank?
      where("password_reset_token = ?", token).first
    end
  end

  def setup_activation
    self.activation_token = generate_random_token
    self.activation_state = "pending"
    self.activation_token_expires_at = nil 
  end

  def send_activation_mail!
    Resque.enqueue(UserMailerWorker, { user_id: self.id, mail_type: "activation_needed" })
  end

  def activate!
    self.activation_token = nil
    self.activation_state = "active"
    send_activation_success_mail!
    save!(validate: false)
  end

  def send_activation_success_mail!
    Resque.enqueue(UserMailerWorker, { user_id: self.id, mail_type: "activation_success" })
  end

  def deliver_password_reset_token
    self.password_reset_token = generate_random_token
    self.password_reset_email_time = Time.now.in_time_zone
    self.password_reset_token_expires_at = nil
    save!(validate: false)
    send_password_reset_mail!
  end

  def send_password_reset_mail!
    Resque.enqueue(UserMailerWorker, { user_id: self.id, mail_type: "password_reset" })
  end

  def change_password!(new_password)
    clear_password_reset_token
    self.password = new_password
    save
  end

  private
  def clear_password_reset_token
    self.password_reset_token = nil
  end

  def generate_random_token
    SecureRandom.base64(15).tr('+/=1I0Q','pqrsxyz')
  end

end