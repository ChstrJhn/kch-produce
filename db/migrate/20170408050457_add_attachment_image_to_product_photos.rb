class AddAttachmentImageToProductPhotos < ActiveRecord::Migration
  def self.up
    change_table :product_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :product_photos, :image
  end
end