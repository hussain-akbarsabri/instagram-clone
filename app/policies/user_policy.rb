# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def public_account?
    role == 'public'
  end

  def private_account?
    role == 'private'
  end

  def index?
    @user.status == 'nil'
  end

  def update?
    false
  end

  def edit?
    update?
  end
end
