# frozen_string_literal: true

module UsersHelper
  def following(current_user_id, followed_user_id)
    relationship = Follow.find_by(follower_id: current_user_id, following_id: followed_user_id)
    return true if relationship
  end

  def requested(current_user_id, followed_user_id)
    requested = Request.find_by(following_id: followed_user_id, follower_id: current_user_id)
    return true if requested
  end

  def post(user)
    checker = user.posts.find { |post| post.user_id == user.id }
    return true if checker
  end

  def story(user)
    checker = user.stories.find { |story| story.user_id == user.id }
    return true if checker
  end

  def private_profile(user)
    user.status
  end
end
