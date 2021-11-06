# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }
    name { Faker::Name.name }
    username { Faker::Name.unique.name[2..15] }
    bio { Faker::Name.name }
  end
end
