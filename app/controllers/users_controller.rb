# frozen_string_literal: true

class UsersController < ApplicationController
  def search
    @users = User.ransack(username_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json { @users = @users.limit(10) }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
