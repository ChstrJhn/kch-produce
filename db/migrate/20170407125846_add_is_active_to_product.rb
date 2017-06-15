class AddIsActiveToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :is_active, :boolean, :default => false
  end
end
