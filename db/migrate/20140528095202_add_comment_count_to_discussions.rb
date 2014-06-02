class AddCommentCountToDiscussions < ActiveRecord::Migration
  def change
  	change_table :nimbos_discussions do |t|
      t.integer  :comments_count, default: 0
    end
  end
end
