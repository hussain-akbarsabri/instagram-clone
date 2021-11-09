# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    images { Rack::Test::UploadedFile.new(Rails.root.join('spec/photos/image.png'), 'image/png') }
    caption { Faker::Name.name }
  end
end
