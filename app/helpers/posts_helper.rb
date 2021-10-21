# frozen_string_literal: true

module PostsHelper
  def post_maker(current_user_id, post_id)
    return true if current_user_id == post_id
  end
end
