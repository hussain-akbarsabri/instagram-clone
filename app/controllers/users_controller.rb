# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def create
    @user = User.new(configure_permitted_parameters)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @posts = @user.posts
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :bio, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
