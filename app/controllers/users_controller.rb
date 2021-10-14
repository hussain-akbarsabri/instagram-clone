# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authorize_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User profile updated successfully.'
      redirect_to @user
    else
      flash[:error] = @user.errors
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :bio, :image, :status)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end
end
