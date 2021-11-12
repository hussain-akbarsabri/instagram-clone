# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        posts = Post.all
        render json: posts
      end
    end
  end
end
