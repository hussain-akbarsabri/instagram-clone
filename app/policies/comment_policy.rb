# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    current_user?
  end

  def destroy?
    current_user?
  end

  private

  def current_user?
    @post = @record.post
    @user == @post.user and @user == @record.user
  end
end
