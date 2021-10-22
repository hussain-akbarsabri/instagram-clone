# frozen_string_literal: true

class ChangeTypeOfBio < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :bio, :text
  end
end
