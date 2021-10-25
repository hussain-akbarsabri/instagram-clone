# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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
