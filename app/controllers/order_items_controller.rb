class OrderItemsController < ApplicationController
 
  def create
    # byebug
    @order = current_order
    if !@order.order_items.where(product_id: order_item_params[:product_id]).any?
      @order_item = @order.order_items.new(order_item_params)
      @order.save
      session[:order_id] = @order.id
    else
      cart_product = OrderItem.find_by(product_id: order_item_params[:product_id], order_id: @order.id)
      # cart_product = @order.order_items.where(product_id: order_item_params[:product_id])
      cart_product.update_attributes(quantity: cart_product.quantity.to_i + order_item_params[:quantity].to_i )
      @order.save
      session[:order_id] = @order.id
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end


private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :unit_price)
  end

end
