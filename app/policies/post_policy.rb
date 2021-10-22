# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
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
    @user == @record.user
  end
end
