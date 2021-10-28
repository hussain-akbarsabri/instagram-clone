# frozen_string_literal: true

if Rails.env.development?
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379', size: 4, network_timeout: 5 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379', size: 4, network_timeout: 5 }
  end
end

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDISCLOUD_CRIMSON_URL'], size: 1, network_timeout: 5 }
  end

  Sidekiq.configure_server do |config|
    pool_size = (Sidekiq.options[:concurrency] + 2)
    config.redis = { url: ENV['REDISCLOUD_CRIMSON_URL'], size: pool_size, network_timeout: 5 }
  end

  Sidekiq::Extensions.enable_delay!
end
