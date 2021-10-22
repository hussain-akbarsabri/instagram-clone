# frozen_string_literal: true

class AddNullToStories < ActiveRecord::Migration[5.2]
  def change
    change_column_null :stories, :user_id, false
    change_column_null :stories, :job_id, false
  end
end
