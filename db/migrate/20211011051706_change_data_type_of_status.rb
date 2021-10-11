# frozen_string_literal: true

class ChangeDataTypeOfStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :status, :boolean, using: 'status::boolean'
  end
end
