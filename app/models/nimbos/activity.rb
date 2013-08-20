module Nimbos
  class Activity < ActiveRecord::Base
  	
	  belongs_to :user
	  belongs_to :patron
	  belongs_to :target, polymorphic: true

	  attr_accessible :target_name, :target, :user_id, :branch_id

	  validates_presence_of :user_id, :patron_id, :target_name, :target

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }

	  scope :latests, order("created_at desc")

	  def self.log(user_id, target, branch_id)
	    activity = Nimbos::Activity.new(target: target, user_id: user_id, target_name: target.to_s, branch_id: branch_id)
	    activity.save!
	    activity
	  end

	  def real_target_type
	    if self.target.is_a? Comment
	      self.comment_target_type
	    else
	      self.target_type
	    end
	  end

  end
end
