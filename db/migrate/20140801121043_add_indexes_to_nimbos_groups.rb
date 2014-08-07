class AddIndexesToNimbosGroups < ActiveRecord::Migration
  def change
  	add_index :nimbos_groups, :patron_id
  	add_index :nimbos_groups, [:grouped_type, :grouped_id]
  end
end
