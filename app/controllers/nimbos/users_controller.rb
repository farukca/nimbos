require_dependency "nimbos/application_controller"

module Nimbos
  class UsersController < ApplicationController
	  before_action :require_login
	  skip_before_action :require_login, :only => [:new, :create, :activate, :activation]
	  before_filter(:only => [:index, :invite_coworkers]) { |c| c.set_tab "usersnavigator" }

	  def index
	    if params[:q]
	      q = "%#{params[:q]}%".to_s.downcase
	      @users = current_patron.users.where("lower(name) like ?", q).order(:name)
	    elsif (params[:all].present? && current_user.superadmin?)
	     	@users = User.order("last_login_at desc").includes(:branch).page(params[:page]).per(10)
	    elsif params[:id].present?
	      query_ids = params[:id].chomp.split(/,/).map { |x| x.to_i }
	      @users = Nimbos::User.where(id: query_ids)
	    else
	      @users = current_patron.users.order(:name).includes(:branch).page(params[:page]).per(10)
	    end

	    respond_to do |format|
	      format.html { render :layout => "admin" } # index.html.erb
	      format.json { render json: @users.map(&:token_inputs) }
	    end
	  end

	  def new
	    @user = Nimbos::User.new
	    if current_user
	      @user = current_patron.users.build()
	    end
	    if current_user
	      render layout: "admin"
	    else
	      render layout: "register"
	    end
	  end

	  def show
	    @user = Nimbos::User.find(params[:id])
	  end

	  def create
	    @user = Nimbos::User.new(user_params)
	    if current_patron
	      @user.patron_id = current_patron.id
	      @user.generate_temp_password
	    else
	    	@user.patron_id = 1
	    end
	    if @user.save
	      redirect_to main_app.root_url, notice: t("users.messages.created")
	    else
	      render :new, layout: "register"
	    end
	  end

	  def activate
	  	if @user = Nimbos::User.load_from_activation_token(params[:id])
	      @user.activate!
	      force_authentication!(@user.patron, @user)
	      if @user.firstuser
	      	redirect_to nimbos.setup_path
	      else
	        redirect_to activation_user_path(@user)
	      end
	    else
	      not_authenticated
	    end
	  end

	  def activation
	    @user = Nimbos::User.find(params[:id])
	    render :layout => 'register'# unless current_user
	  end

	  def edit
	    @user = Nimbos::User.find(params[:id])
	    
	    if (current_user.id != @user.id)
	    	if current_user.has_role? "admin"
	    		[:positions, :loadings, :leads, :vehicles, :companies, :contacts, :drivers, :invoices, :dispatches].each do |resource|
	    			@user.authorizations.build(controller: resource)
	    		end
   	      render :layout => "admin"
   	    else
   	    	redirect_to @user, notice: "You are not authorized for this action"
   	    end
      end
	  end

	  def update
	    @user = Nimbos::User.find(params[:id])

	    if @user.update_attributes(user_params)
	      # if @user.last_login_at.nil?
	      # 	user_params[:email] = @user.email
	      #   #login_user = login(@user.email, user_params[:password], params[:remember_me])
	      #   #if login_user
	      #   if warden.authenticate(:scope => :user)
	      #     #session[:patron_id] = login_user.patron_id if login_user.patron_id
	      #     force_authentication!(current_patron, current_user)
	      #     #redirect_back_or_to root_url, notice: 'Welcome to SocialFreight.'
	      #     #if @user.firstuser
	      #        #redirect_to setup_path(:start_wizard)
	      #     redirect_to main_app.root_url, notice: 'Welcome to SocialFreight.'
	      #     # else
	      #     #   redirect_to new_person_path, notice: 'Welcome to SocialFreight.'
	      #     # end
	      #   else
	      #     render :new, :notice => "Email or password is invalid"
	      #   end
	      # else
	        redirect_to @user, notice: t("users.messages.updated")
	      # end
	    else
	      render :new#, error: "Update error, please try again"
	    end
	    #user = login(params[:email], params[:password], params[:remember_me])

	  end

	  def invite_coworkers
	    @users = Array.new(10) { User.new }
	    render :layout => "admin"
	  end

	  def create_coworkers
	    @branch_id = params[:branch_id]
	    
	    @saved_emails = []
	    @rejected_emails = []
	    @reject_reasons = []
	    params[:user_emails].each do |email|
	      unless email.blank?
	        @user = Nimbos::User.new
	        @user.email     = email
	        @user.branch_id = @branch_id
	        @user.patron_id = current_patron.id
	        @user.password  = "7539518264"
	        @user.password_confirmation  = "7539518264"
	        if @user.valid?
	          @user.save!
	          @saved_emails << email
	        else
	          @rejected_emails << email
	          @reject_reasons << @user.errors.full_messages
	        end        
	      end
	    end
	    render :layout => "admin"
	  end
	  
	  def follow
	    @followable = find_followable
	    unless current_user.follows?(@followable)
	      current_user.follow!(@followable)
	    else
	      current_user.unfollow!(@followable)
	    end
	  end

	  private
	  def user_params
	  	if current_user && (current_user.has_role? :admin)
	  	  params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :avatar, :remove_avatar, :region, :time_zone, :user_type, :language, :locale, :mail_encoding, :branch_id, :user_status, :remember_me, :role_ids => [])
	  	else
	  	  params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :avatar, :remove_avatar, :region, :time_zone, :language, :locale, :mail_encoding, :remember_me)
	  	end  
	  end

  end
end
