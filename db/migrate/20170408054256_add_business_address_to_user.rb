class AddBusinessAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :business_add, :text
  end
end
