require_dependency "nimbos/application_controller"

module Nimbos
  class CurrenciesController < ApplicationController
  	before_filter :require_login
	  layout "admin"
  end
end
