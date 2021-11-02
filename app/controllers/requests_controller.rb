# frozen_string_literal: true

class RequestsController < ApplicationController
  def index
    @requests = Request.where(following_id: current_user.id)
  end

  def destroy
    @request = Request.find(params[:id])
    flash[:alert] = @request.errors.full_messages unless @request.destroy

    redirect_to user_path(current_user)
  end
end
