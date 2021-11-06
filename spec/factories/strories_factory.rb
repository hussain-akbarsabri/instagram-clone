# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    user
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'), 'image/png') }
  end
end
