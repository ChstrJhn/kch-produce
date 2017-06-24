class AddRolesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :merchant, :boolean, default: false
    add_column :users, :user, :boolean, default: true
  end
end
