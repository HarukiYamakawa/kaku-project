host = ENV["REDIS_HOST"] || "redis"
port = ENV["REDIS_PORT"] || 6379


$redis = Redis.new(host: 'redis', port: 6379)