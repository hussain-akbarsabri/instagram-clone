# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'
  validates :follower_id, uniqueness: { scope: :following_id }

  scope :following_id, lambda { |follower_id, following_id|
                         where('follower_id = ? AND following_id = ?', follower_id, following_id)
                       }
end
