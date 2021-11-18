# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :username, :bio, :image

  def image
    object.image.attributes.merge(url: Cloudinary::Utils.cloudinary_url(object.image.key)) if object.image.attached?
  end
end
