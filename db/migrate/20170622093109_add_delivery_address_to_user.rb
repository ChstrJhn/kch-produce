class AddDeliveryAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :delivery_address, :text
  end
end
