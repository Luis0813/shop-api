class ProductImagesController < ApplicationController
  before_action :set_product
  skip_before_action :authenticate!, except: %i[create]
  def show
    if @product.image.attached?
        render json: {
          id: @product.image.id,
          url: url_for(@product.image)
        }
    else
        render json: {
          menssage: "imagen no encontrada"
        }, status: :not_found
    end
  end

  def create
    @product.image.purge if @product.image.attached?
    @product.image.attach(permit_params[:image])
    if @product.image.attached? && @product.image.persisted?
        image_product = @product.image
          render json: {
            id: image_product.id,
            url: url_for(image_product)
          }, status: :created
    else
      render json: { menssage: "hubo un error en el adjunte de la imagen", error: @product&.errors&.[]("image") }, status: :unprocessable_entity
    end
  end

private
  def set_product
    @product = Product.find(params[:product_id])
  end

  def permit_params
     params.permit(:image)
  end
end
