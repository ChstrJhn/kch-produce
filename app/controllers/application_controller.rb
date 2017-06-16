class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order

  def current_order
  	# FIX must only in-progress orders
    if current_user && !session[:order_id].nil? && Order.find(session[:order_id]).present?
      Order.find(session[:order_id])
    elsif current_user && current_user.orders.where(order_status_id: 1).present?
      current_user.orders.where(order_status_id: 1).first
    else
      Order.new(user_id: current_user.id)
    end
  end


  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :short_summary, :contact_number, :business_add])
  end

end
