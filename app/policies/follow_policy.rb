# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def follow?
    current_user?
  end

  def unfollow?
    follow_created?
  end

  private

  def current_user?
    @user.id != @record.following_id
  end

  def follow_created?
    @user.id == @record.follower_id
  end
end
