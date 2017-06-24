class CreateProfileImages < ActiveRecord::Migration[5.0]
  def change
    create_table :profile_images do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
