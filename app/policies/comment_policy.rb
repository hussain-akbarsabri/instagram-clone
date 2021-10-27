# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    allowed_user?
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
    @post = @record.post
    @user == @post.user or @user == @record.user
  end
end
