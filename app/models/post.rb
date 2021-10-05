# frozen_string_literal: true

class Post < ApplicationRecord
  validates :image, attached: true
  has_one_attached :image
  has_many :likes, dependent: :destroy
  belongs_to :user
end
