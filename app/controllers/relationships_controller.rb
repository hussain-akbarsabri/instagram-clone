# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :set_user, only: %i[follow_user unfollow_user]

  def follow_user
    @follow = Follow.new
    @follow.following_id = @user.id
    @follow.follower_id = current_user.id

    if @follow.save
      flash[:notice] = 'Follow started successfully.'
    else
      flash[:error] = @follow.errors
    end
    redirect_to user_path(params[:id])
  end

  def unfollow_user
    if Follow.find_by(following_id: @user.id).destroy
      flash[:notice] = 'Following deleted successfully.'
    else
      flash[:error] = @post.errors
    end
    redirect_to user_path(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
