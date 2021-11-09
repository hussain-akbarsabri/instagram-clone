# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    allowed_user?
  end

  def edit?
    allowed_user?
  end

  def update?
    allowed_user?
  end

  def destroy?
    allowed_user?
  end

  private

  def allowed_user?
    set_follower
    @user.id == @record.post.user_id || (!@record.post.user.status && comment_maker) || (@follower &&
      @record.post.user.status && comment_maker)
  end

  def comment_maker
    @user.id == @record.user_id
  end

  def set_follower
    @follower = @user.followings.find_by(following_id: @record.post.user_id, follower_id: @user.id).present?
  end
end
