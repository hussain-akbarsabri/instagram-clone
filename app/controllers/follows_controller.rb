# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_user, only: %i[follow_user unfollow_user send_request_for_private]
  before_action :check_follower, only: %i[follow_user unfollow_user]
  before_action :send_request_for_private, only: %i[follow_user]

  def follow_user
    if current_user.id != @user.id
      flash[:notice] = 'Follow started.' if Follow.new(following_id: @user.id, follower_id: current_user.id).save
    else
      flash[:alert] = 'You cant follow your own account.'
    end
    redirect_to user_path(params[:id])
  end

  def unfollow_user
    if @follow
      if @follow.destroy
        flash[:notice] = 'Unfollow started.'
      else
        flash[:error] = @post.errors
      end
    else
      flash[:alert] = 'You cant unfollow if not following'
    end
    redirect_to user_path(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_follower
    @follow = Follow.find_by(following_id: @user.id)
  end

  def send_request_for_private
    return unless @user.status?

    if Request.new(following_id: @user.id, follower_id: current_user.id).save
      flash[:notice] = 'Follow request sent.'
    else
      flash[:alert] = 'You cant send follow request.'
    end
    redirect_to user_path(params[:id])
  end
end
