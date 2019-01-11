require 'redis'
REDIS = Redis.new(host: Rails.application.credentials.redis[:REDIS_HOST], port: Rails.application.credentials.redis[:REDIS_PORT])
