# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :caption, :images

  def images
    object.images.map do |image|
      Cloudinary::Utils.cloudinary_url(image.key)
    end
  end
end
