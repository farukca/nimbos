require_dependency "nimbos/application_controller"

module Nimbos
  class CountersController < ApplicationController

    def new
    	@counter = Nimbos::Counter.find_by(counter_type: params[:counter_type]) || Nimbos::Counter.new(counter_type: params[:counter_type])
    end

    def create
    end

    def update
    end

  end
end
