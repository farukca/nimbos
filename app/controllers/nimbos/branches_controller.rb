require_dependency "nimbos/application_controller"

module Nimbos
  class BranchesController < ApplicationController
	  before_filter :require_login

	  def index
	    @branches = Nimbos::Branch.all
	    render :layout => "nimbos/admin"
	  end

	  def new
	    @branch = Nimbos::Branch.new
	  end

	  def edit
	    @branch = Nimbos::Branch.find(params[:id])
	  end

	  def create
	    @branch = Nimbos::Branch.new(params[:branch])

	    respond_to do |format|
	      if @branch.save
	        format.html { redirect_to @branch.patron, notice: 'Branch was successfully created.' }
	        format.json { render json: @branch, status: :created, location: @branch }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @branch.errors, status: :unprocessable_entity }
	      end
	    end
	  end
  end
end
