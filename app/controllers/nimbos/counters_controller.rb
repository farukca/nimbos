require_dependency "nimbos/application_controller"

module Nimbos
  class CountersController < ApplicationController

    def new
    	@counter = Nimbos::Counter.find_by(counter_type: params[:counter_type]) || Nimbos::Counter.new(counter_type: params[:counter_type])
    end

    def edit
    	@counter = Nimbo::Counter.find(params[:id])
    end

    def create
    	@counter = Nimbo::Counter.new(counter_params)
    	respond_to do |format|
    		if @counter.save
    			format.html { redirect_to @counter, notice: t("simple_form.default.message.created", model: Nimbo::Counter.model_name.human) }
    			format.json { render json: @counter, status: :created, location: @counter }
    			format.js { flash.now[:notice] = t("simple_form.default.message.created", model: Nimbo::Counter.model_name.human) }
    		else
    			format.html { render action: "new" }
    			format.json { render json: @counter.errors }
    			format.js
            end
        end
    end

    def update
    	@counter = Nimbo::Counter.find(params[:id])
    	respond_to do |format|
    		if @counter.update_attributes(counter_params)
    			format.html { redirect_to @counter, notice: t("simple_form.default.message.update", model: Nimbo::Counter.model_name.human) }
    			format.json { head :ok}
    			format.js { flash.now[:notice] = t("simple_form.default.message.update", model: Nimbo::Counter.model_name.human) }
    		else
    			format.html { render action: "edit" }
    			format.json { render json: @counter.errors }
    			format.js
            end
        end
    end

  end
end
