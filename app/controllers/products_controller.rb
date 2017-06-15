class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @products = current_user.products
  end

  def show
    @product_photos = @product.product_photos
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save

      if params[:images]
        params[:images].each do |image|
          @product.product_photos.create(image: image)
        end
      end

      @photos = @product.product_photos      
      redirect_to @product, notice: "Saved!"
    else
      redirect :new
    end
  end

  def edit
    if current_user.id == @product.user.id
      @product_photos = @product.product_photos
    else
      redirect_to root_path, notice: "You cannot edit this product."
    end
  end

  def update
    if @product.update(product_params)

      if params[:images]
        params[:images].each do |image|
          @product.product_photos.create(image: image)
        end
      end

      redirect_to edit_product_path(@product), notice: "Updated!"
    else
      render :edit
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:product_name, :product_type, :short_description, :origin, :brand,
      								  :estimated_delivery, :price, :price_per, :stock_count, :long_description, :highlight_one, :highlight_two, :highlight_three, :unit_mass, :mass)
    end

end
