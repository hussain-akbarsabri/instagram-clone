# frozen_string_literal: true

class AddIndexToFollows < ActiveRecord::Migration[5.2]
  def change
    remove_index :follows, [:follower_id]
    add_index :follows, [:follower_id], unique: true
  end
end
