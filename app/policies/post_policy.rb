# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    super(user)
    @user = user
    @post = post
  end

  def update?
    user.admin? || !post.published?
  end
end
