# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :force_json, only: :search

  def search
    @users = User.ransack(username_cont: params[:q]).result(distinct: true).limit(5)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def force_json
    request.format = :json
  end
end
