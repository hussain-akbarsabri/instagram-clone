# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  attr_reader :user, :request

  def initialize(user, request)
    super(user)
    @user = user
    @request = request
  end

  def user?
    current_user.id == @user.id
  end
end
