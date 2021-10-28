# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true if @user.followings.find_by(follower_id: @user.id, following_id:
      @record.user_id) || !allowed_user?
  end

  def destroy?
    @user == @record.user
  end

  private

  def allowed_user?
    @post = @record.post
    @user != @post.user
  end
end
