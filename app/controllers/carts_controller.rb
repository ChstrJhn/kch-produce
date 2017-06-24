class CartsController < ApplicationController
  def show
  	 @order_items = current_order.order_items
  	 @order = current_order
  	 @products = Product.all
  end
end
