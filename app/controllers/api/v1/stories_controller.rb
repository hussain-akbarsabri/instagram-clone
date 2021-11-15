# frozen_string_literal: true

module Api
  module V1
    class StoriesController < ApplicationController
      def index
        render json: Story.all.with_attached_image
      end
    end
  end
end
