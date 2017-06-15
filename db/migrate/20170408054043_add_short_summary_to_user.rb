class AddShortSummaryToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :short_summary, :string
  end
end
