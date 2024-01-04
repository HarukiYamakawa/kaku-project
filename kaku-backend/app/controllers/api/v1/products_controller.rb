require 'rest-client'
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
    product = Product.new(product_params)

    if Rails.env.production?
      lambda_url = ENV['LAMBDA_PUSH_IMAGE_URL']
      image_file = Base64.strict_encode64(params[:product][:image].read)
      response = RestClient.post(lambda_url, { image_file: image_file }.to_json, content_type: :json, accept: :json)
      product.image_url = JSON.parse(response.body)['url']
    end

    if product.save
      render status: :ok
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
