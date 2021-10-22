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
    current_user?
  end

  private

  def current_user?
    @user == @record
  end
end
