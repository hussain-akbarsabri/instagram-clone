# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_user, only: %i[accept_follow]
  before_action :authenticate_user!

  def show
    @requests = Request.where(following_id: params[:id])
  end

  def accept_follow
    @request = Request.find_by!(following_id: params[:id])
    if Follow.new(following_id: @user.id, follower_id: @request.follower_id).save
      flash[:notice] = 'Request accepted and Follow started.'
    end
    @request.destroy

    redirect_to user_path(params[:id])
  end

  def destroy
    @request = Request.find_by!(following_id: params[:id])
    flash[:notice] = 'Request deleted' if @request.destroy
    redirect_to user_path(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
