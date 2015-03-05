require_dependency "nimbos/application_controller"

module Nimbos
  class BranchesController < ApplicationController
	  before_filter :require_login
	  before_filter(:only => [:index]) { |c| c.set_tab "branchesnavigator" }
	  layout "admin"

	  def index
	    @branches = Nimbos::Branch.all
	  end

	  def new
	    @branch = Nimbos::Branch.new
	  end

	  def edit
	    @branch = Nimbos::Branch.find(params[:id])
	  end

	  def create
	    @branch = Nimbos::Branch.new(branch_params)

	    respond_to do |format|
	      if @branch.save
	        format.html { redirect_to nimbos.branches_path, notice: t("simple_form.messages.defaults.created", model: Nimbos::Branch.model_name.human) }
	        format.json { render json: @branch, status: :created, location: @branch }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @branch.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	  	@branch = Nimbos::Branch.find(params[:id])

	    respond_to do |format|
	      if @branch.update_attributes(branch_params)
	        format.html { redirect_to nimbos.branches_path, notice: t("simple_form.messages.defaults.updated", model: Nimbos::Branch.model_name.human) }
	        format.json { head :ok }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @branch.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def destroy
	  	@branch = Nimbos::Branch.find(params[:id])
      @branch.destroy

      respond_to do |format|
        format.html { redirect_to nimbos.branches_path, notice: t("simple_form.messages.defaults.deleted", model: Nimbos::Branch.model_name.human) }
        format.json { head :ok }
      end
    end

	  private
	  def branch_params
	  	params.require(:branch).permit(:name, :tel, :fax, :postcode, :district, :address, :city, :country_id, :status, :patron_id)
	  end
  end
end
