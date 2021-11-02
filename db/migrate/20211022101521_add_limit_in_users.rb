# frozen_string_literal: true

class AddLimitInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :username, :string, limit: 15
  end
end
