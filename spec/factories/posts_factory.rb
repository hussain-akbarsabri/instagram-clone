# frozen_string_literal: true

include ActionDispatch::TestProcess::FixtureFile

FactoryBot.define do
  factory :post do
    images { fixture_file_upload(Rails.root.join('spec/photos/image.png')) }
    caption { Faker::Name.name }
  end
end
