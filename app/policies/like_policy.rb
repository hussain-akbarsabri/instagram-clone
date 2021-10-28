# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    @post = Post.find(@record.post_id)

    @user.followings.find_by(following_id:
      @post.user_id, follower_id: @user.id).present? || @user == @post.user
  end

  def destroy?
    @user == @record.user
  end
end
