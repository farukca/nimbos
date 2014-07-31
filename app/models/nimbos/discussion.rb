module Nimbos
  class Discussion < ActiveRecord::Base

    belongs_to :user, class_name: "Nimbos::User"
	  belongs_to :target, polymorphic: true
	  has_many :comments, as: :commentable, class_name: "Nimbos::Comment", dependent: :destroy

	  attr_accessor :related_user_ids, :target_name

	  #validates :user_id, presence: true
	  validates :title, presence: true, length: { maximum: 255 }
	  validates :content, length: { maximum: 1000 }
	  
	  default_scope { where(patron_id: Nimbos::Patron.current_id) }
	  scope :latests, order("created_at desc")

	  def to_s
	  	title
	  end

	  def to_param
	  	"#{id}-#{title.parameterize}"
	  end
  end
end
