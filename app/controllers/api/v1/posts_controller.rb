# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        render json: Post.all.with_attached_images
      end
    end
  end
end
