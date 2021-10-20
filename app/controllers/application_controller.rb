# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
  rescue_from ActionController::RoutingError, with: :handle_routing_error

  include Pundit

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username name bio image status])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username name bio image status])
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def record_not_found
    flash[:alert] = 'Record Not Found'
    redirect_to root_path
  end

  def not_authorized_error
    flash[:alert] = 'You are not authorized.'
    redirect_to root_path
  end

  def handle_routing_error
    flash[:alert] = 'This route is not defined.'
    redirect_to root_path
  end
end
