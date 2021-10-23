# frozen_string_literal: true

class RemoveNullFromJobid < ActiveRecord::Migration[5.2]
  def change
    change_column_null :stories, :job_id, true
  end
end
