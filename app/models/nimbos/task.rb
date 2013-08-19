module Nimbos
  class Task < ActiveRecord::Base

	  belongs_to :todolist, counter_cache: true, touch: true
	  belongs_to :user
	  belongs_to :cruser, :class_name => "User", :foreign_key => "cruser_id"

	  attr_accessible :user_id, :task_text, :task_code, :due_date, :status, :close_text, :closed_date, :system_task

	  validates :task_text, presence: true, length: { minimum: 2, maximum: 1000 }
	  validates :cruser_id, presence: true

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }
	  scope :active, where(status: "active")
  end
end
