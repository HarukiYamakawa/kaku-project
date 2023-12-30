class Api::V1::ProductsController < ApplicationController
  def index
    redis_key = 'products_list'
    begin
      cached_products = $redis.get(redis_key)
  
      if cached_products.nil?
        # Active Model SerializersやJbuilderを使用してシリアライズ
        products = Product.all # 必要に応じてクエリを最適化
        serialized_products = ActiveModelSerializers::SerializableResource.new(products).to_json
        $redis.set(redis_key, serialized_products)
        $redis.expire(redis_key, 10.seconds.to_i)
      else
        products = JSON.parse(cached_products)
      end
    rescue => e
      Rails.logger.error "Redis error: #{e}"
      products = Product.all # Redisエラー時のフォールバック
    end
    render json: products
  end

  def show
    product = Product.find_by(id: params[:id])
    response.headers["Cache-Control"] = "public, s-maxage=60, stale-while-revalidate=60"
    render json: product
  end
end
