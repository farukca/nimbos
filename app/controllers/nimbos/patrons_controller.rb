require_dependency "nimbos/application_controller"

module Nimbos
  class PatronsController < ApplicationController

	  before_filter :require_login, except: [:new, :create]
	  before_filter(:only => [:index]) { |c| c.set_tab "patronsnavigator" }
	  before_filter(:only => [:show]) { |c| c.set_tab "patronnavigator" }
    layout "admin"

    def new
    	@patron = Nimbos::Patron.new
	    respond_to do |format|
	      format.html { render layout: "register" }
	      format.json { render json: @patron }
	    end
    end

	  def index
	    @patrons = Nimbos::Patron.order("id desc").all

	    respond_to do |format|
	      format.html
	      format.json { render json: @patrons }
	    end
	  end

	  def show
	    @patron = Nimbos::Patron.find(params[:id])

	    respond_to do |format|
	      format.html
	      format.json { render json: @patron }
	    end
	  end

	  def edit
	    @patron = Nimbos::Patron.find(params[:id])
	  end

	  def create
	    @patron = Nimbos::Patron.new(patron_params)
	    @country = Nimbos::Country.find(patron_params[:country_id]) unless patron_params[:country_id].blank?
	    if @country
		    @patron.language = @country.language
		    @patron.locale   = @country.locale
		    @patron.mail_encoding = @country.mail_encoding
		    @patron.time_zone = @country.time_zone
		  end

	    respond_to do |format|
	      if @patron.save
	        format.html { render 'check_mail', notice: t("simple_form.messages.defaults.created", model: Nimbos::Branch.model_name.human), layout: 'homepage' }
	        format.json { render json: @patron, status: :created, location: @patron }
	      else
	        format.html { render action: "new", layout: "register" }
	        format.json { render json: @patron.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    @patron = Nimbos::Patron.find(params[:id])

	    respond_to do |format|
	      if @patron.update_attributes(patron_params)
	        format.html {
	        	if params[:patron][:step].present?
	        		redirect_to nimbos.start_path
	        	else
	        		redirect_to @patron, notice: t("simple_form.messages.defaults.updated", model: Nimbos::Patron.model_name.human), layout: 'nimbos/admin' 
	        	end
	       	}
	        format.json { head :ok }
	        format.js
	      else
	        format.html { render action: "edit", layout: 'nimbos/admin' }
	        format.json { render json: @patron.errors, status: :unprocessable_entity }
	        format.js
	      end
	    end
	  end

	  def jump	  	
	  	unless current_user.superadmin?
	  		redirect_to :back, notice: "You are not authorized"
	  	else
	  		@patron = Nimbos::Patron.find(params[:id])
	  		current_user.update_attributes(patron_id: @patron.id)
	  		force_authentication!(@patron, current_user)
	  		redirect_to @patron
	  	end
	  end

	  private
	  def patron_params
	  	params.require(:patron).permit(:name, :website, :tel, :fax, :postcode, :district, :address, :city, :country_id, :status, :email, :operations, :contact_name, :contact_surname, :time_zone, :language, :logo, :logo_cache, :remove_logo, :vehicle_owner, :depot_owner, :patron_type, :iata_code, :fmc_code, :locale, :mail_encoding, :title, :currency, :username, :password, :step, :counters_attributes, :users_attributes, branches_attributes: [:id, :name, :country_id, :city])
	  end

  end
end
