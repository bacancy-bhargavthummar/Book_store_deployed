# frozen_string_literal: true

class ChangeIsbnTypeInBooks < ActiveRecord::Migration[6.0]
  def change
    change_column :books, :isbn, :string
  end
end
