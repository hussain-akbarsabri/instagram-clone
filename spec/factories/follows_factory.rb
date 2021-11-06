# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    follower_id { 10 }
    following_id { 10 }
  end
end
