class AddIndexesToNimbosPatrons < ActiveRecord::Migration
  def change
  	add_index :nimbos_patrons, :name
  	add_index :nimbos_patrons, :country_id
  end
end
