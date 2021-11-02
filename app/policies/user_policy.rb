# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    allowed_user?
  end

  private

  def allowed_user?
    @user == @record
  end
end
