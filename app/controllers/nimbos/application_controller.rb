module Nimbos
  class ApplicationController < ActionController::Base
	  protect_from_forgery

	  around_filter :scope_current_patron
	  around_filter :user_time_zone, if: :current_user
	  before_filter :set_locale

	  def follow_object(object)
	    current_user.follow(object)
	  end

	  #private
	  #def current_patron
	  #  #@current_patron ||= Patron.find(session[:patron_id]) if session[:patron_id]
	  #  @current_patron ||= Patron.find(current_user.patron_id) if current_user
	  #end
	  #helper_method :current_patron

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

    def warden
    	env['warden']
    end

	  def scope_current_patron
	    Patron.current_id = current_patron.id if current_patron
	    yield
	  ensure
	    Patron.current_id = nil
	  end

	  def require_patron
	    if !patron_user?
	      session[:return_to_url] = request.url if Config.save_return_to_url
	      self.send(Config.not_authenticated_action)
	    end
	  end

		def force_authentication!(patron, user)
			warden.set_user(user, :scope => :user)
			warden.set_user(patron, :scope => :patron)
		end

	  def not_authenticated
	    redirect_to nimbos.login_path, :alert => "Please login first."
	  end

	  def patron_user?
	    !!current_patron
	  end

	  def set_locale
	    #locale = logged_in? ? current_user.locale : (params[:locale])
	    if user_signed_in?
	      locale = current_user.language
	    end
	    unless locale.present?
	      locale = ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
	    end
	    unless locale.present?
	      locale = cookies[:socialfreight_locale]
	    end
	    unless locale.present?
	      locale = Timeout::timeout(5) { Net::HTTP.get_response(URI.parse('http://api.hostip.info/country.php?ip=' + request.remote_ip )).body } rescue I18n.default_locale
	      cookies[:socialfreight_locale] = locale
	    end

	    I18n.locale = (locale.present? && I18n.available_locales.include?(locale.to_sym)) ? locale : I18n.default_locale
	  end
	  
	  def user_time_zone(&block)
	    Time.use_zone(current_user.time_zone, &block)
	  end
  end
end
