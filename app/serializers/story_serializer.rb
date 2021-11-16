# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  attributes :id, :image

  def image
    object.image.attributes.merge(url: Cloudinary::Utils.cloudinary_url(object.image.key)) if object.image.attached?
  end
end
