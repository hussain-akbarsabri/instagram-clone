# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_user, only: %i[accept_follow]
  before_action :authenticate_user!

  def show
    @requests = Request.where(following_id: params[:id])
  end

  # move logic into model

  def accept_follow
    @request = Request.find_by!(following_id: params[:id])
    if Follow.create(following_id: @user.id, follower_id: @request.follower_id)
      flash[:notice] = 'Request accepted and Follow started.'
    end
    flash[:notice] = 'Request didnt deleted.' unless @request.destroy
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
