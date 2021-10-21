# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username name bio image status])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username name bio image status])
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_out_path_for(resource)
    new_user_session_path(resource)
  end
end
