class AddIndexesToNimbosCounters < ActiveRecord::Migration
  def change
  	add_index :nimbos_counters, :patron_id
  end
end
