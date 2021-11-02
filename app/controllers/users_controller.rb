# frozen_string_literal: true

class UsersController < ApplicationController
  def search
    @users = User.ransack(username_cont: params[:q]).result

    respond_to do |format|
      format.html {}
      format.json { @users = @users.limit(10) }
    end
  end

  def show
    @user = User.find(params[:id])
    @request = Request.find_by(following_id: @user.id, follower_id: current_user.id)
  end
end
