# frozen_string_literal: true

class FollowPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def follow?
    !allowed_user?
  end

  def unfollow?
    follow_creator?
  end

  def accept_follow?
    allowed_user?
  end

  def send_request?
    allowed_user?
  end

  private

  def allowed_user?
    @user.id == @record.following_id
  end

  def follow_creator?
    @user.id == @record.follower_id
  end
end
