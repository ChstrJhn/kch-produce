class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :short_description
      t.string :origin
      t.string :brand
      t.integer :estimated_delivery
      t.string :type
      t.integer :price
      t.string :price_per
      t.integer :stock_count
      t.text :long_description
      t.string :highlight_one
      t.string :highlight_two
      t.string :highlight_three
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
