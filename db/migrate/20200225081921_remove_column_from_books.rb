# frozen_string_literal: true

class RemoveColumnFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :user_id
  end
end
