module Nimbos
  class Todolist < ActiveRecord::Base

	  has_many   :tasks, class_name: "Nimbos::Task"
	  belongs_to :todop, polymorphic: true, touch: true
    belongs_to :user, class_name: "Nimbos::User"

	  accepts_nested_attributes_for :tasks

	  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
	  #validates :user_id, presence: true

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }

    def to_param
    	"#{id}-#{name.parameterize}"
    end

	  def incomplete_tasks
	    tasks.where(status: "active").order(:created_at)
	  end

	  def completed_tasks
	    tasks.where(status: "closed").order(:created_at)
	  end
  end
end
