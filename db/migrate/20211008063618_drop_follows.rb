# frozen_string_literal: true

class DropFollows < ActiveRecord::Migration[5.2]
  def change
    drop_table :follows do |t|
      t.integer :following_id
      t.integer :follower_id
    end
  end
end
