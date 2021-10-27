# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    post_owner?
  end

  def create?
    post_owner?
  end

  def show?
    return true if @user.followings.find_by(follower_id: @user.id, following_id:
      @record.user_id) || @user.id == @record.user_id || !User.find(@record.user_id).status
  end

  def edit?
    post_owner?
  end

  def update?
    post_owner?
  end

  def destroy?
    post_owner?
  end

  private

  def post_owner?
    @user == @record.user
  end 
end
