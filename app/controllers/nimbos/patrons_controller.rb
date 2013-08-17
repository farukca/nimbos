require_dependency "nimbos/application_controller"

module Nimbos
  class PatronsController < ApplicationController

	  before_filter :require_login, except: [:new, :create]

    def new
    	@patron = Nimbos::Patron.new
	    respond_to do |format|
	      format.html #{ render layout: "guest" }
	      format.json { render json: @patron }
	    end
    end

	  def index
	    @patrons = Nimbos::Patron.order("id desc").all

	    respond_to do |format|
	      format.html { render layout: "nimbos/admin" }
	      format.json { render json: @patrons }
	    end
	  end

	  def show
	    @patron = Nimbos::Patron.find(params[:id])

	    respond_to do |format|
	      format.html { render layout: "nimbos/admin" }
	      format.json { render json: @patron }
	    end
	  end

	  def edit
	    @patron = Nimbos::Patron.find(params[:id])
	  end

	  def create
	    @patron = Nimbos::Patron.new(params[:patron])
	    @country = Nimbos::Country.find(params[:patron][:country_id]) unless params[:patron][:country_id].blank?
	    if @country
		    @patron.language = @country.language
		    @patron.locale   = @country.locale
		    @patron.mail_encoding = @country.mail_encoding
		    @patron.time_zone = @country.time_zone
		  end

	    respond_to do |format|
	      if @patron.save
	        #format.html { redirect_to @patron, notice: 'Patron was successfully created.' }
	        format.html { render 'check_mail', notice: 'Patron was successfully created.', layout: 'nimbos/guest' }
	        format.json { render json: @patron, status: :created, location: @patron }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @patron.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    @patron = Nimbos::Patron.find(params[:id])

	    respond_to do |format|
	      if @patron.update_attributes(params[:patron])
	        format.html { redirect_to @patron, notice: 'Patron was successfully updated.', layout: 'nimbos/admin' }
	        format.json { head :ok }
	      else
	        format.html { render action: "edit", layout: 'nimbos/admin' }
	        format.json { render json: @patron.errors, status: :unprocessable_entity }
	      end
	    end
	  end

  end
end
