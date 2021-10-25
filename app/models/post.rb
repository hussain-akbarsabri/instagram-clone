# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :images, attached: true, limit: { min: 1, max: 10 }, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validates :caption, length: { maximum: 150 }
end
