module Nimbos
  class Group < ActiveRecord::Base

  	has_and_belongs_to_many :users, class_name: "Nimbos::User", join_table: "nimbos_users_groups" #, association_foreign_key: "user_id"#, foreign_key: "group_id"
	  belongs_to :grouped, :polymorphic => true
	  belongs_to :admin, class_name: Nimbos::User

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }

	  validates :title, length: { maximum: 255 }

	  def self.add_group(user_id, parent, user_ids)
	  	#remove blank ve double user ids
	  	user_ids << user_id.to_s
	  	user_ids.compact
	    user_ids.reject! { |uid| uid.empty? }
      Rails.logger.info("Group users ids #{user_ids}")

	    group = Nimbos::Group.new(grouped: parent, admin_id: user_id, title: parent.to_s[0..250], hidden: true)
	    group.users << Nimbos::User.find(user_ids)
	    group.save!
	    group
	  end

	  def group_users_ids
	  	users.pluck(:user_id).join(",")
	  end

  end
end
