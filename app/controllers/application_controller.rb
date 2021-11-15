# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
  rescue_from ActionController::RoutingError, with: :route_not_found

  include Pundit

  def route_not_found
    render 'users/route_not_found'
  end

  private

  def record_not_found
    flash[:alert] = 'Record Not Found'
    redirect_to root_path
  end

  def not_authorized_error
    flash[:alert] = 'You are not authorized.'
    redirect_to root_path
  end
end
