# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def accept_follow?
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
