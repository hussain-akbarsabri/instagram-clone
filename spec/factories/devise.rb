# frozen_string_literal: true

pass = Faker::Internet.password(min_length: 6)

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { pass }
    password_confirmation { pass }
    name { Faker::Name.name }
    username { Faker::Name.unique.name[2..15] }
    bio { Faker::Name.name }
    status { false }
  end
end
