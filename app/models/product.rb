class Product < ApplicationRecord
  belongs_to :user
  has_many :product_photos

  # add validations
end
