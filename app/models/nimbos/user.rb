module Nimbos
  class User < ActiveRecord::Base
	  include Nimbos::Concerns::Authentication
    include Messenger::Concerns::Messagable
    include Messenger::Concerns::Notifiable
	  #rolify

	  #acts_as_follower
	  #acts_as_followable
	  #acts_as_liker
	  #acts_as_mentionable
	  #include GeneratesNick

	  mount_uploader :avatar, AvatarUploader

	  belongs_to :patron
	  belongs_to :branch
    has_and_belongs_to_many :roles,  :join_table => :nimbos_users_roles
    has_and_belongs_to_many :groups, class_name: "Nimbos::Group", join_table: "nimbos_users_groups" #, foreign_key: "user_id"

	  has_many :authorizations, dependent: :destroy
	  accepts_nested_attributes_for :authorizations, reject_if: lambda { |a| a[:controller].blank? }

	  has_many :activities
	  has_many :comments
	  has_many :posts
	  has_many :tasks
	  has_many :reminders

    attr_accessor :remember_me
	  #attr_accessible :email, :password, :password_confirmation, :name, :surname, :avatar, :remove_avatar, 
	  #                :region, :time_zone, :user_type, :language, :locale, :mail_encoding, :role_ids, :branch_id, :user_status, :remember_me
	  #attr_protected  :password

	  validates :password, presence: { on: :create }, confirmation: { on: :create }, length: { minimum: 6, maximum: 20, on: :create }
	  validates :email, presence: { on: :create }, uniqueness: { case_sensitive: false }, length: { in: 7..60 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
	  validates :name, presence: true, on: :update
	  #validates :surname, presence: true, on: :update
	  validates :branch_id, presence: true
	  #validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

	  default_scope { where(is_guest: false) }
	  scope :active,  -> { where(user_status: "active") }
	  scope :online,  -> { where("last_activity_at > ?", 10.minutes.ago) }
	  scope :offline, -> { where("last_activity_at < ?", 10.minutes.ago) }

	  before_create :get_user_name_from_email

    def self.user_status
    	%w[active nonactive]
    end

	  def token_inputs
	    { id: id, text: to_s }
	  end

	  def generate_token(column)
	    begin
	      self[column] = SecureRandom.urlsafe_base64
	    end while Nimbos::User.where(column: self[column]).exists?#(conditions: {column: self[column]})
	  end

	  def to_s
	    name
	  end

	  def to_param
      "#{id}-#{name.parameterize if name.present?}"
    end

	  def social_name
	    email
	  end

	  def get_user_name_from_email
	  	if self.name.blank?
	  		self.name = self.email.split("@").first.gsub(/[.-_]/, ' ').titleize 
	  	end
	  end

    def role_names
    	roles.map(&:name)
    end
    #https://github.com/martinrehfeld/role_model/blob/master/lib/role_model/implementation.rb
    def has_any_role?(role_name)
      #roles.flatten.map(&:to_sym).any? { |r| self.role_names.include?(r) }
      self.role_names.include?(role_name.to_s)
    end
    alias_method :has_role?, :has_any_role?

    def superadmin?
    	self.rootuser
    end

    def authorized_for?(controller, action)
    	is_authorized = true
    	auth_rec = self.authorizations.find_by(controller: controller)
    	if auth_rec
    		if (auth_rec.can_manage) ||
    		   (auth_rec.can_read   && (action == "show")) ||
    		   (auth_rec.can_create && (action == "new")) ||
       		 (auth_rec.can_update && (action == "edit")) ||
       		 (auth_rec.can_delete && (action == "destroy"))
    			is_authorized = true
    		else
    			is_authorized = false
    		end
    	else
    		is_authorized = false
    	end
    	is_authorized
    end

	  def generate_temp_password
	    self.password = generate_random_token#SecureRandom.base64(15).tr('+/=1I0Q','pqrsxyz')#"9516284"
	    self.password_confirmation = self.password
	  end

	  #def create_activity(target, target_name, patron_id, patron_token)
	  #  #creator_id ||= target.user_id
	  #  target_name ||= target.to_s
	  #  Nimbos::Activity.log(self, target, target_name, patron_id, patron_token)
	  #end

	  def social_posts
	    ##@social_posts = Nimbos::Post.where("user_id IN (?) OR user_id = ? ", self.followees(User), self.id).limit(6).order("created_at desc")
	    @social_posts = Nimbos::Post.includes(:user).includes(:comments).limit(10).order("created_at desc")
	  end

	  def active_tasks_count
	    self.tasks.where(status: "active").count
	  end

	  def next_week_reminders_count
	  	self.reminders.where(start_date: Time.zone.today..(Time.zone.today + 1.week)).count
	  end

  end
end
