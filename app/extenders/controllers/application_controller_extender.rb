::ApplicationController.class_eval do

	def current_patron
		if user_signed_in?
			@current_patron ||= begin
				patron_id = warden.user(:scope => :patron) || current_user.patron_id
				Nimbos::Patron.find(patron_id)
			end
		end
	end
	helper_method :current_patron

	def current_user
		if user_signed_in?
			@current_user ||= begin
				user_id = warden.user(:scope => :user)
				Nimbos::User.find(user_id)
			end
		end
	end
	helper_method :current_user

	def user_signed_in?
    warden.authenticated?(:user)
  end
  helper_method :user_signed_in?

  def require_login
    unless user_signed_in?
    	session[:return_to_url] = request.url if request.get?
    	not_authenticated
    end
  end

	def force_authentication!(patron, user)
		warden.set_user(user, :scope => :user)
		warden.set_user(patron, :scope => :patron)
	end

private
	def not_authenticated
	  redirect_to nimbos.login_path, :alert => "Please login first."
	end

  def warden
    env['warden']
  end

end