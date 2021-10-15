# frozen_string_literal: true

json.array!(@users) do |user|
  json.username user.username
  json.url user_path(user)
end
