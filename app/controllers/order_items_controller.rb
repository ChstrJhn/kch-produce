class OrderItemsController < ApplicationController

  before_action :order_in_progress
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
 
  def create
    product = Product.find(order_item_params[:product_id])

    unless product.stock_count.to_i <= 0 || order_item_params[:quantity].to_i > product.stock_count.to_i
      
      if !@order.order_items.where(product_id: order_item_params[:product_id]).any?
        @order_item = @order.order_items.new(order_item_params)
        @order.save
        product.update_attributes(stock_count: product.stock_count.to_i - order_item_params[:quantity].to_i)
        session[:order_id] = @order.id
      else
        @order_item = OrderItem.find_by(product_id: order_item_params[:product_id], order_id: @order.id)
        @order_item.update_attributes(quantity: @order_item.quantity.to_i + order_item_params[:quantity].to_i )
        @order.save
        product.update_attributes(stock_count: product.stock_count.to_i - order_item_params[:quantity].to_i)
        session[:order_id] = @order.id
      end

    else
      flash[:info] = "More than available stock. Please refresh"
      return
    end
    flash.now[:notice] = "Added to cart" 

    respond_to :js
  end

  def update 
    @order_items = current_order.order_items
    @order_item = @order_items.find(params[:id])
    product = Product.find(@order_item.product_id)


    if product.stock_count.to_i > 0 && product.stock_count.to_i > order_item_params[:quantity].to_i

      if @order_item.quantity.to_i > order_item_params[:quantity].to_i
        difference = @order_item.quantity.to_i - order_item_params[:quantity].to_i
        product.update_attributes(stock_count: product.stock_count.to_i + difference.to_i)
        @order_item.update_attributes(order_item_params)

      elsif @order_item.quantity.to_i < order_item_params[:quantity].to_i
        difference = order_item_params[:quantity].to_i - @order_item.quantity.to_i
        product.update_attributes(stock_count: product.stock_count.to_i - difference.to_i)
        @order_item.update_attributes(order_item_params)
      end

    elsif product.stock_count.to_i > 0 && order_item_params[:quantity].to_i > product.stock_count.to_i + @order_item.quantity.to_i  
      flash.now[:info] = "More than available stock. Please refresh"

    elsif product.stock_count.to_i > 0 && order_item_params[:quantity].to_i == product.stock_count.to_i + @order_item.quantity.to_i
      difference = order_item_params[:quantity].to_i - @order_item.quantity.to_i
      product.update_attributes(stock_count: product.stock_count.to_i - difference.to_i)
      @order_item.update_attributes(order_item_params)

    elsif product.stock_count.to_i > 0 && order_item_params[:quantity].to_i > product.stock_count.to_i + @order_item.quantity.to_i  
      flash.now[:info] = "More than available stock. Please refresh"

    elsif product.stock_count.to_i >= 0 && order_item_params[:quantity].to_i < product.stock_count.to_i + @order_item.quantity.to_i
      difference = @order_item.quantity.to_i - order_item_params[:quantity].to_i
      product.update_attributes(stock_count: product.stock_count.to_i + difference.to_i)
      @order_item.update_attributes(order_item_params)

    elsif product.stock_count.to_i == 0 && order_item_params[:quantity].to_i > product.stock_count.to_i + @order_item.quantity.to_i
      flash.now[:info] = "More than available stock. Please refresh"

    end

    respond_to :js
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    product = Product.find(@order_item.product_id)
    product.update_attributes(stock_count: product.stock_count.to_i + @order_item.quantity.to_i)
    @order_item.destroy
    @order_items = @order.order_items

    respond_to :js
  end


private

  def order_in_progress
    @order = current_order
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :unit_price)
  end

end
