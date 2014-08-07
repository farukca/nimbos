class AddIndexesToNimbosTasks < ActiveRecord::Migration
  def change
  	add_index :nimbos_tasks, :patron_id
  	add_index :nimbos_tasks, :user_id
  	add_index :nimbos_tasks, :todolist_id
  end
end
