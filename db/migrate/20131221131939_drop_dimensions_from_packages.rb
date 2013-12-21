class DropDimensionsFromPackages < ActiveRecord::Migration

  def up
  	remove_column :logistics_packages, :dimension1
  	remove_column :logistics_packages, :dimension2
  	remove_column :logistics_packages, :dimension3
  	add_column :logistics_packages, :dimension, :string, limit: 255
  end

  def down
  	add_column :logistics_packages, :dimension1, :integer, default: 0
  	add_column :logistics_packages, :dimension2, :integer, default: 0
  	add_column :logistics_packages, :dimension3, :integer, default: 0
  	remove_column :logistics_packages, :dimension
  end

end
