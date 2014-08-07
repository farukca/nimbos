class AddIndexesToNimbosBranches < ActiveRecord::Migration
  def change
  	add_index :nimbos_branches, :patron_id
  end
end
