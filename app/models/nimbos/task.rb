module Nimbos
  class Task < ActiveRecord::Base

	  belongs_to :todolist, class_name: "Nimbos::Todolist", counter_cache: true, touch: true
	  belongs_to :user, class_name: "Nimbos::User"
	  belongs_to :cruser, class_name: "Nimbos::User", foreign_key: "cruser_id"

	  has_many :comments, as: :commentable, class_name: "Nimbos::Comment", dependent: :destroy

	  validates :task_text, presence: true, length: { minimum: 2, maximum: 255 }
	  validates :cruser_id, presence: true
	  validates :todolist_id, presence: true
	  validates :task_code, :i18n_code, length: { maximum: 50 }
	  validates_associated :todolist

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }
	  scope :active, where(status: "active")
  end
end
