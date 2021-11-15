# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def index
        render json: Post.all.with_attached_images
      end
    end
  end
end
