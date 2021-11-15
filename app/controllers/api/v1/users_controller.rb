# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: User.all.with_attached_image
      end
    end
  end
end
