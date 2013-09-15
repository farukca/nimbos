module Nimbos
  class User < ActiveRecord::Base
	  include Nimbos::Concerns::Authentication

	  #rolify

	  #acts_as_follower
	  #acts_as_followable
	  #acts_as_liker
	  #acts_as_mentionable
	  #include GeneratesNick

	  mount_uploader :avatar, AvatarUploader

	  belongs_to :patron
    has_and_belongs_to_many :roles, :join_table => :nimbos_users_roles

	  #has_one  :person
	  has_many :activities
	  has_many :comments
	  has_many :posts
	  has_many :tasks
	  has_many :reminders

    attr_accessor :remember_me
	  attr_accessible :email, :password, :password_confirmation, :name, :surname, :avatar, :remove_avatar, 
	                  :region, :time_zone, :user_type, :language, :locale, :mail_encoding, :role_ids, :branch_id, :user_status, :remember_me
	  #attr_protected  :password

	  validates :password, presence: { on: :create }, confirmation: { on: :create }, length: { minimum: 6, maximum: 20, on: :create }
	  validates :email, presence: { on: :create }, uniqueness: { case_sensitive: false }, length: { in: 7..60 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
	  validates :name, presence: true, on: :update
	  validates :surname, presence: true, on: :update
	  validates :branch_id, presence: true
	  #validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)
	  scope :active, where(user_status: "active")
	  scope :online, lambda{ where("last_activity_at > ?", 10.minutes.ago) }
	  scope :offline, lambda{ where("last_activity_at < ?", 10.minutes.ago) }

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
	    "#{name} #{surname}"
	  end

	  def to_param
      "#{id}-#{to_s.parameterize}"
    end

	  def social_name
	    email
	  end

	  def generate_temp_password
	    self.password = "9516284"
	    self.password_confirmation = "9516284"
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

	  #def active_tasks
	    #@tasks = Nimbos::Task.includes(:user).active.where(user_id: self.id)
	  #end
  end
end
