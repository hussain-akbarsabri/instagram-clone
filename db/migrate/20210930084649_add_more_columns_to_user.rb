# frozen_string_literal: true

class AddMoreColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :name
      t.string :username
      t.string :mobile_number
      t.string :bio
      t.integer :status
    end
  end
end
