::ApplicationController.class_eval do

  around_filter :scope_current_patron

	def current_patron
		if user_signed_in?
			@current_patron ||= begin
				patron_id = warden.user(:scope => :patron) #|| (current_user.patron_id if current_user)
				Nimbos::Patron.find(patron_id)
			end
		end
	end
	helper_method :current_patron

	def current_user
		if user_signed_in?
			@current_user ||= begin
				user_id = warden.user(:scope => :user)
				Nimbos::User.unscoped.find(user_id)
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
    else
    	if current_user.is_guest
    		session[:return_to_url] = nil
    		warden.logout
    		redirect_to main_app.root_url
    	end
    end
  end

	def force_authentication!(patron, user)
		warden.set_user(user.id, :scope => :user)
		warden.set_user(patron.id, :scope => :patron)
	end

	def generate_group(parent, user_ids)
		#user_ids << current_user.id
    Nimbos::Group.add_group(current_user.id, parent, user_ids)
	end

private
	def not_authenticated
	  redirect_to nimbos.login_path, :alert => "Please login first."
	end

  def warden
    env['warden']
  end

  def scope_current_patron
    Nimbos::Patron.current_id = current_patron.id if current_patron
    yield
  ensure
    Nimbos::Patron.current_id = nil
  end
end