# frozen_string_literal: true

module ApplicationHelper
  def user_status_current(current_user_id, check_user_id)
    current_user = current_user_id == check_user_id
    return true if current_user
  end
end
