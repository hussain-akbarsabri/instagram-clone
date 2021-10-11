# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :set_user, only: %i[create show]

  def create
    @request = Request.new(following_id: @user.id, follower_id: current_user.id)

    if @request.save
      flash[:notice] = 'Follow Request sent.'
    else
      flash[:errors] = 'request not sent'
    end
    redirect_to root_path
  end

  def show
    @requests = Request.where(following_id: params[:id])
  end

  def accept
    flash[:notice] = 'I have accepted request'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
