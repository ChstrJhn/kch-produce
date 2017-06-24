class ProductPhotosController < ApplicationController

  def destroy
  	@photo = ProductPhoto.find(params[:id])
  	product = @photo.product

  	@photo.destroy
  	@product_photos = ProductPhoto.where(product_id: product.id)

  	respond_to :js
  end

end