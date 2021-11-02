# frozen_string_literal: true

class Story < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
