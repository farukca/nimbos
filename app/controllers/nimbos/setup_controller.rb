require_dependency "nimbos/application_controller"

module Nimbos
  class SetupController < ApplicationController
	  before_filter :require_login

	  def new
	  	@patron = current_patron
	  end
	  
  end
end
