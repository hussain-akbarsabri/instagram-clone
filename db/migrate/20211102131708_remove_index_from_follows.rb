class RemoveIndexFromFollows < ActiveRecord::Migration[5.2]
  def change
    remove_index :requests, [:follower_id]
    add_index :requests, [:follower_id]
  end
end
