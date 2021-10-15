# frozen_string_literal: true

class AddDefaultValueToStatusAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :status, :boolean, default: false
  end
end
