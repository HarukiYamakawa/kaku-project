class Api::V1::ProductsController < ApplicationController
  def index
    redis_key = 'products_list'
    begin
      cached_products = $redis.get(redis_key)

      if cached_products.nil?
        products = Product.all
        serialized_products = ActiveModelSerializers::SerializableResource.new(products).to_json
        $redis.set(redis_key, serialized_products)
        $redis.expire(redis_key, 10.seconds.to_i)
      else
        products = JSON.parse(cached_products)
      end
    rescue StandardError
      products = Product.all
    end
    render json: products
  end

  def show
    product = Product.find_by(id: params[:id])
    response.headers['Cache-Control'] = 'public, max-age=60, s-maxage=60, stale-while-revalidate=60'
    render json: product
  end

  def create
    registration_params = product_params
    registration_params[:image_url] = '#'
    product = Product.new(registration_params)
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image_url)
  end
end
