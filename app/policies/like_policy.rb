# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    current_user?
  end

  def destroy?
    current_user?
  end

  private

  def current_user?
    @post = @record.user
  end
end
