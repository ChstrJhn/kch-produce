class AddContactNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :contact_number, :integer
  end
end
