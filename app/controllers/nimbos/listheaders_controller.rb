require_dependency "nimbos/application_controller"

module Nimbos
  class ListheadersController < ApplicationController
	  before_filter :require_login
	  layout "admin"

	  def index
	  	@listheaders = Nimbos::Listheader.all
	  end

	  def new
	  	@listheader = Nimbos::Listheader.new
	  	@listitem = @listheader.listitems.build()
	  end

	  def show
	  	@listheader = Nimbos::Listheader.find(params[:id])
	  end

	  def edit
	  	@listheader = Nimbos::Listheader.find(params[:id])
	  end

	  def create
	    @listheader = Nimbos::Listheader.new(listheader_params)
	    
	    respond_to do |format|
	      if @listheader.save
	        format.html { redirect_to @listheader, notice: 'listheader was successfully created.' }
	        format.json { render json: @listheader, status: :created, location: @listheader }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @listheader.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    @listheader = Nimbos::Listheader.find(params[:id])

	    respond_to do |format|
	      if @listheader.update_attributes(listheader_params)
	        format.html { redirect_to @listheader, notice: 'listheader was successfully updated.' }
	        format.json { head :ok }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @listheader.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  private
	  def listheader_params
	  	params.require(:listheader).permit(:code, :description, :i18n_code, :name, :listitems_attributes)
	  end
  end
end
