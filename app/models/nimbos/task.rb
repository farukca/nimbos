module Nimbos
  class Task < ActiveRecord::Base

	  belongs_to :todolist, class_name: "Nimbos::Todolist", counter_cache: true, touch: true
	  belongs_to :user, class_name: "Nimbos::User"
	  belongs_to :cruser, class_name: "Nimbos::User", foreign_key: "cruser_id"

	  validates :task_text, presence: true, length: { minimum: 2, maximum: 1000 }
	  validates :cruser_id, presence: true

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }
	  scope :active, where(status: "active")
  end
end
