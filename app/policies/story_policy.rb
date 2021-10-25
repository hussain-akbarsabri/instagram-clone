# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true if @user.followings.find_by(follower_id: @user.id,
                                            following_id: @record.user_id) || @user.id == @record.user_id
  end

  def edit?
    post_owner?
  end

  def update?
    post_owner?
  end

  def destroy?
    post_owner?
  end

  private

  def post_owner?
    @user == @record.user
  end
end
