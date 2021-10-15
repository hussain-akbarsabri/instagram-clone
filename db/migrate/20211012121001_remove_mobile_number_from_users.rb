# frozen_string_literal: true

class RemoveMobileNumberFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :mobile_number, :string
  end
end
