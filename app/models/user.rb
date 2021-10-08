# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :username, presence: true

  has_many :followers, foreign_key: :following_id, class_name: 'Follow', dependent: :restrict_with_exception,
                       inverse_of: false
  has_many :followings, foreign_key: :follower_id, class_name: 'Follow', dependent: :restrict_with_exception,
                        inverse_of: false
end
