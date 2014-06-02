class AddCommentCountToTasks < ActiveRecord::Migration
  def change
  	change_table :nimbos_tasks do |t|
      t.integer  :comments_count, default: 0
    end
  end
end
