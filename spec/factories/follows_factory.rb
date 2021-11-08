# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    follower_id { Faker::Number.number(digits: 10) }
    following_id { Faker::Number.number(digits: 10) }
  end
end
