# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
  include Pundit

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
