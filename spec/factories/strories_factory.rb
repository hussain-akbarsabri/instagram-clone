# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    user
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/temp.txt'), 'file/txt') }
    job_id { DeleteStoryJob.set(wait: 24.hours).perform_later(@story).provider_job_id }
  end
end
