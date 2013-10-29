module Nimbos
  class Patron < ActiveRecord::Base
	  include CustomValidators::Validators
	 
	  mount_uploader :logo, LogoUploader

	  has_many :counters, class_name: "Nimbos::Counter"
	  accepts_nested_attributes_for :counters, :allow_destroy => true
	  
	  has_many :branches
	  accepts_nested_attributes_for :branches, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
	  
	  has_many :users
	  accepts_nested_attributes_for :users, :reject_if => lambda { |a| a[:email].blank? }, :allow_destroy => true  

	  attr_accessor :username

	  def self.current_id=(id)
	    Thread.current[:patron_id] = id
	  end

	  def self.current_id
	    Thread.current[:patron_id]
	  end

	  before_create :set_initials
	  after_create  :create_head_office, :create_patron_user#, :create_company #, :create_admin_user

	  validates :name, presence: true, length: { in: 2..40 }
	  validates :email, check_registered: { message: I18n.t("patrons.messages.mailexists"), on: :create}, 
	                    presence: true, 
	                    uniqueness: { case_sensitive: false, on: :create }, length: { in: 7..60 }, 
	                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
	  validates :contact_name, presence: true, length: { in: 2..40 }
	  #validates :contact_surname, presence: true, length: { in: 2..40 }
	  validates :password, presence: { on: :create }, length: { minimum: 6, maximum: 20, on: :create }
	  validates :tel, presence: true, length: { in: 2..20 }
	  validates :country_id, presence: true
	  validates :title, length: { maximum: 60 }
	  validates :username, absence: true

	  def to_s
	  	name
	  end

	  def to_param
	  	"#{id}-#{name.parameterize}"
	  end

	  def self.generate_counter(ctype, operation, direction)
	    patron = Nimbos::Patron.find(Nimbos::Patron.current_id)
	    counter = patron.counters.find_or_initialize_by_counter_type(ctype)

	    case ctype
	      when "Company"
	      	counter.prefix = "ACC"
	      when "Loading"
	        counter.prefix = "BKG"
	      when "Position"
	        counter.prefix = "PRJ"
	      when "Ticket"
	        counter.prefix = "TLP"
	    end

	    counter.increment(:count, 1)
	    counter.save!
	    return counter.get_reference
	  end

	  def set_activity(target, action, creator_id=nil, action_text, user_name)
	    creator_id ||= target.user_id
	    #return log_later(target, action, creator_id) if self.is_importing
	    Nimbos::Activity.log(self, target, action, creator_id, action_text, user_name, self.patron_token)
	  end

	  private
	  def set_initials
	    self.title = self.name
	    self.patron_token = SecureRandom.urlsafe_base64[0,40]
	  end

	  private
	  def create_head_office
	    Nimbos::Patron.current_id = self.id
	    branch = self.branches.new
	    branch.name = "Head Office"
	    branch.tel = self.tel
	    branch.fax = self.fax
	    branch.country_id = self.country_id
	    branch.patron_id = self.id
	    branch.save!
	  end

	  #def create_admin_user
	  #  branch = Branch.where(patron_id: self.id).first
	  #  user = self.users.new
	  #  user.name = "SocialFreight"
	  #  user.surname = "Admin"
	  #  user.email = "faruk@socialfreight.com"
	  #  user.language = self.language
	  #  user.locale   = self.locale
	  #  user.mail_encoding = self.mail_encoding
	  #  user.time_zone = self.time_zone
	  #  user.branch_id  = branch.id
	  #  user.password = SecureRandom.urlsafe_base64[0,10]
	  #  user.password_confirmation = user.password
	  #  user.save!
	  #  user.add_role :super
	  #end

	  def create_patron_user
	    branch = Nimbos::Branch.where(patron_id: self.id).first
	    user      = self.users.new
	    user.name     = self.contact_name
	    user.surname  = self.contact_surname
	    user.email    = self.email
	    user.language = self.language
	    user.locale   = self.locale
	    user.mail_encoding = self.mail_encoding
	    user.time_zone = self.time_zone
	    user.branch_id = branch.id
	    user.password  = self.password
	    user.password_confirmation = self.password
	    user.firstuser = true
	    user.save!
	    #user.add_role :admin
	  end

#	  def create_company
#	    branch = Branch.where(patron_id: self.id).first
#	    user   = User.where(patron_id: self.id).last
#	    company = Company.new
#	    company.name = self.name
#	    company.tel = self.tel
#	    company.fax = self.fax
#	    company.country_id = self.country_id
#	    company.patron_id = self.id
#	    company.branch_id  = branch.id
#	    company.user_id = user.id
#	    company.save!
#	  end

    def self.generate_random_token
      SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
    end

  end
end
