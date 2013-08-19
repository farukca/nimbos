class CreateBetausers < ActiveRecord::Migration
  def change
    create_table :betausers do |t|
      t.string :email
      t.string :name
      t.string :company
      t.string :phone
      t.string :country
      t.string :ipaddr

      t.timestamps
    end
  end
end
