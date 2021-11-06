# frozen_string_literal: true

class RemoveNullFromFollower < ActiveRecord::Migration[5.2]
  def change
    change_column_null :follows, :following_id, true
    change_column_null :follows, :follower_id, true
  end
end
