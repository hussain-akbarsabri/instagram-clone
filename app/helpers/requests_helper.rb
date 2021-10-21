# frozen_string_literal: true

module RequestsHelper
  def requester_username(follower_id)
    User.find(follower_id).username
  end
end
