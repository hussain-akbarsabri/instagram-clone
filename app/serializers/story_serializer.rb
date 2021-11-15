# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :image

  def image
    return unless object.image.attached?

    object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: image_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def image_url
    Cloudinary::Utils.cloudinary_url(object.image.key)
  end
end
