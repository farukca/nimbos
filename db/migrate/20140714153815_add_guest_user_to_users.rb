class AddGuestUserToUsers < ActiveRecord::Migration
  def change
  	change_table :nimbos_users do |t|
  		t.boolean  :is_guest, default: false
  	end
  end
end
