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
      products[0].name = 'Redis is not working'
    end
    render json: products, status: :ok
  end

  def show
    product = Product.find_by(id: params[:id])
    response.headers['Cache-Control'] = 'public, max-age=60, s-maxage=60, stale-while-revalidate=60'
    render json: product
  end
end
