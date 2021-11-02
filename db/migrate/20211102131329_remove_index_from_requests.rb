# frozen_string_literal: true

class RemoveIndexFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_index :follows, [:follower_id]
    add_index :follows, [:follower_id]
  end
end
