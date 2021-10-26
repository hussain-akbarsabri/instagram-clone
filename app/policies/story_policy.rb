# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    story_owner?
  end

  def show?
    return true if @user.followings.find_by(follower_id: @user.id, following_id:
      @record.user_id) || @user.id == @record.user_id || !User.find(@record.user_id).status
  end

  def edit?
    story_owner?
  end

  def update?
    story_owner?
  end

  def destroy?
    story_owner?
  end

  private

  def story_owner?
    @user == @record.user
  end
end
