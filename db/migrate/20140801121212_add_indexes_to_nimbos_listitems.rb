class AddIndexesToNimbosListitems < ActiveRecord::Migration
  def change
  	add_index :nimbos_listitems, :listheader_id
  end
end
