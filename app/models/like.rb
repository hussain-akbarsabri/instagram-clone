# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :liked, ->(p_id, u_id) { where('post_id = ? AND user_id = ?', p_id, u_id) }
end
