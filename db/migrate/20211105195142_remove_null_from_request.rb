# frozen_string_literal: true

class RemoveNullFromRequest < ActiveRecord::Migration[5.2]
  def change
    change_column_null :requests, :following_id, true
    change_column_null :requests, :follower_id, true
  end
end
