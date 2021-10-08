# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[edit update]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User updated successfully.'
      redirect_to @user
    else
      flash[:error] = @user.errors
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'User deleted successfully.'
      redirect_to @user
    else
      flash[:error] = @user.errors
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :bio, :image, :status)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
