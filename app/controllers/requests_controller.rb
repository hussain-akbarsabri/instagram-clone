# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_user, only: %i[send_follow_request accept_follow_request]

  def send_follow_request
    if current_user.id != @user.id
      flash[:notice] = 'Follow request sent.' if Request.new(following_id: @user.id, follower_id: current_user.id).save
    else
      flash[:alert] = 'You cant follow your own account.'
    end
    redirect_to user_path(params[:id])
  end

  def show
    @requests = Request.where(following_id: params[:id])
  end

  def accept_follow_request
    @request = Request.find_by(following_id: params[:id])
    if Follow.new(following_id: @user.id, follower_id: @request.follower_id).save
      flash[:notice] = 'Request accepted and Follow started.'
    end
    @request.destroy

    redirect_to user_path(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
