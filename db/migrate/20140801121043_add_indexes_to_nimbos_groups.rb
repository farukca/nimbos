class AddIndexesToNimbosGroups < ActiveRecord::Migration
  def change
  	add_index :nimbos_groups, :patron_id
  end
end
