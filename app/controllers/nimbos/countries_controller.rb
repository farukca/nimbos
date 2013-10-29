require_dependency "nimbos/application_controller"

module Nimbos
  class CountriesController < ApplicationController
	  before_filter :require_login
	  #caches_action :index
	  layout "admin"

	  def new
	    @country = Nimbos::Country.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @country }
	    end
	  end

	  def edit
	    @country = Nimbos::Country.find(params[:id])
	  end

	  def index
	    @countries = Nimbos::Country.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @countries }
	    end
	  end

	  def show
	    @country = Nimbos::Country.find(params[:id])
	    @marker  = @country.to_gmaps4rails

	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @country }
	    end
	  end

	  def create
	    @country = Nimbos::Country.new(country_params)

	    respond_to do |format|
	      if @country.save
	        format.html { redirect_to countries_path, notice: 'Country was successfully created.' }
	        format.json { render json: @country, status: :created, location: @country }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @country.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    @country = Nimbos::Country.find(params[:id])

	    respond_to do |format|
	      if @country.update_attributes(country_params)
	        format.html { redirect_to countries_path, notice: 'Country was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @country.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def country_params
	  	params.require(:country).permit(:name, :code, :telcode, :locale, :language, :time_zone, :mail_encoding)
	  end
  end
end
