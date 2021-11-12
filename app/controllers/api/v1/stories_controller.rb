# frozen_string_literal: true

module Api
  module V1
    class StoriesController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        stories = Story.all
        render json: stories
      end
    end
  end
end
