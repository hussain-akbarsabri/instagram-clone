# frozen_string_literal: true

$redis = Resque.redis = Redis.new(url: ENV['REDIS_END_POINT']) if ENV['REDIS_END_POINT']
