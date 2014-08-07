class AddIndexesToNimbosComments < ActiveRecord::Migration
  def change
  	add_index :nimbos_comments, :patron_id
  	add_index :nimbos_comments, [:commentable_type, :commentable_id]
  end
end
