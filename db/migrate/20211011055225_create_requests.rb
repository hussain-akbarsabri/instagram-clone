# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer 'following_id', null: false
      t.integer 'follower_id', null: false

      t.timestamps
    end

    add_index :requests, :following_id
    add_index :requests, :follower_id
  end
end
