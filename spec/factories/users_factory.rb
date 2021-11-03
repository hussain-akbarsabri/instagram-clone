# frozen_string_literal: true

include ActionDispatch::TestProcess::FixtureFile

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }
    name { Faker::Name.name }
    username { Faker::Name.unique.name[2..15] }
    bio { Faker::Name.name }
    image { fixture_file_upload(Rails.root.join('spec/photos/image.png')) }
  end
end
