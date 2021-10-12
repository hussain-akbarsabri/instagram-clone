# frozen_string_literal: true

module UsersHelper
  def current_user_is_following(current_user_id, followed_user_id)
    relationship = Follow.find_by(follower_id: current_user_id, following_id: followed_user_id)
    return true if relationship
  end

  def current_user_is_requested(current_user_id, followed_user_id)
    requested = Request.find_by(following_id: followed_user_id, follower_id: current_user_id)
    return true if requested
  end
end
