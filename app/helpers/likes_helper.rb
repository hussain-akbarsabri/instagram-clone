# frozen_string_literal: true

module LikesHelper
  def liked(post)
    liked = post.likes.find { |like| like.user_id == current_user.id }
    return true if liked
  end

  def many_likes(count)
    return true if count > 1
  end
end
