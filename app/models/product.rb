class Product < ApplicationRecord
  belongs_to :user
  has_many :product_photos
  has_many :order_items

  # default_scope { where(is_active: true) }
  # limit short description to 150 words

  # def check_available_stock(order_item_params)

  #   if @order_item.quantity.to_i > order_item_params[:quantity].to_i
  #     difference = @order_item.quantity.to_i - order_item_params[:quantity].to_i
  #     product.update_attributes(stock_count: product.stock_count.to_i + difference.to_i)
  #   elsif @order_item.quantity.to_i < order_item_params[:quantity].to_i
  #     difference = order_item_params[:quantity].to_i - @order_item.quantity.to_i
  #     product.update_attributes(stock_count: product.stock_count.to_i - difference.to_i)
  #   end
  # end

end
