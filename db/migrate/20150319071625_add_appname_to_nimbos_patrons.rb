class AddAppnameToNimbosPatrons < ActiveRecord::Migration
  def change
    add_column :nimbos_patrons, :appname, :string, limit: 30
  end
end
