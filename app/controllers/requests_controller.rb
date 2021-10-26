# frozen_string_literal: true

class RequestsController < ApplicationController
  def show
    @requests = Request.where(following_id: params[:id])
  end

  def destroy
    @request = Request.find_by!(following_id: params[:id])
    flash[:alert] = @request.errors.full_messages unless @request.destroy

    redirect_to user_path(params[:id])
  end
end
