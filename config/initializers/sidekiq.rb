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
    config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
  end
end
