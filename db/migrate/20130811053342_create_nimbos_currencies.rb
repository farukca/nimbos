class CreateNimbosCurrencies < ActiveRecord::Migration
  def change
    create_table :nimbos_currencies, :primary_key => :code do |t|
      t.string :code, :limit => 5, :null => false
      t.string :name, :limit => 40, :null => false
      t.string :symbol, :limit => 1
      t.double :multiplier, :default => 1, :null => false

      t.timestamps
    end
  end
end
