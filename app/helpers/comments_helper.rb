# frozen_string_literal: true

module CommentsHelper
  def commentor_login(current_user_id, commenter_id)
    return true if current_user_id == commenter_id
  end
end
