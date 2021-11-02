# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    set_follower
    @user.id == @record.post.user_id || (@follower && @record.post.user.status) || (!@follower &&
      !@record.post.user.status)
  end

  def destroy?
    @user == @record.user
  end

  private

  def set_follower
    @follower = @user.followings.find_by(following_id: @record.post.user_id, follower_id: @user.id).present?
  end
end
