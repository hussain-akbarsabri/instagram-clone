# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :image, attached: true
end
