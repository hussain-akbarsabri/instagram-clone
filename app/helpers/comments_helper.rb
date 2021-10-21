# frozen_string_literal: true

module CommentsHelper
  def commentor_maker(current_user_id, commenter_id)
    return true if current_user_id == commenter_id
  end
end
