# frozen_string_literal: true

Redis.new(host: ENV['REDIS_END_POINT'], port: ENV['REDIS_PORT'], password: ENV['REDIS_PASSWORD'])
