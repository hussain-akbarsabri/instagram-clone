# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  attr_reader :user, :request

  def initialize(user, request)
    super(user)
    @user = user
    @request = request
  end

  def send_follow?
    current_user.id == @user.id
  end
end
