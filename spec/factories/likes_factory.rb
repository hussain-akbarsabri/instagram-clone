# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    user
    post
    post_id { post.id }
    user_id { user.id }
  end
end
