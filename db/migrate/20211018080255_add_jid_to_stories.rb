# frozen_string_literal: true

class AddJidToStories < ActiveRecord::Migration[5.2]
  def change
    change_table :stories do |t|
      t.string :job_id
    end
  end
end
