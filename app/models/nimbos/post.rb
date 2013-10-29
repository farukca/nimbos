module Nimbos
  class Post < ActiveRecord::Base

	  belongs_to :user, class_name: "Nimbos::User"
	  belongs_to :target, polymorphic: true
	  belongs_to :parent, polymorphic: true

	  has_many :comments, as: :commentable, class_name: "Nimbos::Comment", dependent: :destroy

	  attr_accessor :related_user_ids

	  validates_presence_of :user_id, :message

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }
	  scope :latests, order("created_at desc")

	  after_create  :set_after_jobs

	  def self.create_post(user_id, message, object, object_title, object_url, parent, parent_title, parent_url, action_type, channel, private_flag, syspost_flag)
	    post = Nimbos::Post.new(message: message)
	    post.user_id      = user_id 
	    post.target       = object
	    post.target_title = object_title
	    post.target_url   = object_url
	    post.parent       = parent
	    post.parent_title = parent_title
	    post.parent_url   = parent_url
	    post.post_action  = action_type
	    post.channel      = channel
	    post.is_private   = private_flag
	    post.is_syspost   = syspost_flag
	    post.save!    
	    post
	  end

	  def last_comment
	    comments.last
	  end

	  def title
	  	"#{user}'s post"
	  end

	private
	  def set_after_jobs
	    if self.related_user_ids && self.related_user_ids.length > 0
	      connect_users(self.related_user_ids)
	    end
	  end

	  def connect_users(userids)
	    userids.split(",").each do |userid|
	      @user = Nimbos::User.find(userid)
	      self.mention!(@user) if @user
	    end
	  end
  end
end
