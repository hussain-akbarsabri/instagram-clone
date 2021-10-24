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
  has_many :stories, dependent: :destroy

  has_many :followers, foreign_key: :following_id, class_name: 'Follow', dependent: :restrict_with_exception,
                       inverse_of: false
  has_many :followings, foreign_key: :follower_id, class_name: 'Follow', dependent: :restrict_with_exception,
                        inverse_of: false

  validates :username, presence: true, uniqueness: true, length: { minimum: 2, maximum: 15 }
  validates :name, length: { maximum: 30 }
  validates :bio, length: { maximum: 50 }
end
