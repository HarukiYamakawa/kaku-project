# if Rails.env.production?
#   redis_url = ENV["REDIS_URL"] # 本番環境用のRedis URL
# else
#   host = 'redis'
#   port = 6379
# end

$redis = Redis.new(host: 'redis', port: 6379)