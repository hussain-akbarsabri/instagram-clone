# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters, only: [:create]
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

  def show; end

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

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

  def user_params
    params.require(:user).permit(:username, :name, :bio, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
