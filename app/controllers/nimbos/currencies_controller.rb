require_dependency "nimbos/application_controller"

module Nimbos
  class CurrenciesController < ApplicationController
  	before_filter :require_login
	  layout "admin"

	  def index
	  	@currencies = Nimbos::Currency.all
	  end
  end
end
