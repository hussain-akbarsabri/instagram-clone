# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!

      def index
        render json: User.all.with_attached_image
      end
    end
  end
end
