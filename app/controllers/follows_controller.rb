# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_user, only: %i[follow unfollow send_request]
  before_action :set_follower, only: %i[unfollow]
  before_action :send_request, only: %i[follow]

  def follow
    @follow = Follow.new(following_id: @user.id, follower_id: current_user.id)
    authorize @follow
    flash[:alert] = @follow.errors.full_messages unless @follow.save

    redirect_to user_path(params[:id])
  end

  def unfollow
    authorize @follow
    flash[:alert] = @follow.errors.full_messages unless @follow.destroy

    redirect_to user_path(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_follower
    @follow = Follow.find_by!(following_id: @user.id)
  end

  def send_request
    return unless @user.status

    @request = Request.new(following_id: @user.id, follower_id: current_user.id)
    flash[:alert] = @request.errors.full_messages unless @request.save

    redirect_to user_path(params[:id])
  end
end
