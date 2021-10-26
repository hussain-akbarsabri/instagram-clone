# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    current_user?
  end

  private

  def current_user?
    @user == @record
  end
end
