class RemoveNameFromProduct < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :field_name, :string
    remove_column :products, :name, :string
  end
end
