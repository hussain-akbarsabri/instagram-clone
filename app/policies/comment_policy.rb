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
    @post = Post.find(@record.post_id)
    @user.followings.find_by(following_id:
      @post.user_id, follower_id: @user.id).present? || @user == @post.user || @user == @record.user
  end
end
