class Product < ApplicationRecord
  belongs_to :user
  has_many :product_photos
  has_many :order_items

  # default_scope { where(is_active: true) }

end
