class AddFieldsToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :mass, :integer
  	add_column :products, :unit_mass, :string
  	remove_column :products, :price_per, :string
  end
end
