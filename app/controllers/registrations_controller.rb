# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  # Add the following

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    new_user_session_path(resource)
  end
end
