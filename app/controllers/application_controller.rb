class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order

  def current_order
    if current_user && !session[:order_id].nil? && Order.find_by(id: session[:order_id], user_id: current_user.id, order_status_id: 1).present?
     current_user.orders.find_by(id: session[:order_id], user_id: current_user.id, order_status_id: 1)
    elsif current_user && current_user.orders.where(order_status_id: 1).present?
      current_user.orders.find_by(order_status_id: 1)
    elsif current_user && !current_user.orders.where(order_status_id: 1).present?
      Order.new(user_id: current_user.id)
    else
      Order.new
    end
  end


  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :short_summary, :contact_number, :business_add, :merchant, :profile_image])
  end

end
