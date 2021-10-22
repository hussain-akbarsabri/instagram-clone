# frozen_string_literal: true

class AddLimitInUsersToName < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, limit: 15
  end
end
