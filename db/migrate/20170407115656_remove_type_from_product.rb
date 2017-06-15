class RemoveTypeFromProduct < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :field_name, :string
    remove_column :products, :type, :string
  end
end
