class ProductController < ApplicationController
  skip_before_action :authenticate!, except: %i[create]

    def index
       @products = Product.all
       @products = @products.map do |product|
        product.as_json.merge({ image: product.image.attached? ? url_for(product.image) : nil })
      end
       render json: @products
    end


  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  # POST /product
  def create
    @product = Product.create!(create_params)
    render json: @product, status: :created
  end


  def create_params
    params.require(:product).permit(:name, :description, :price, :discount_price)
  end
  def update_params
    params.require(:product).permit(:name, :description, :price, :discount_price)
  end
end
