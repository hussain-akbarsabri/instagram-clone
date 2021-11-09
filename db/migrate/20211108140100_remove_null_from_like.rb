# frozen_string_literal: true

class RemoveNullFromLike < ActiveRecord::Migration[5.2]
  def change
    change_column_null :likes, :post_id, true
    change_column_null :likes, :user_id, true
  end
end
