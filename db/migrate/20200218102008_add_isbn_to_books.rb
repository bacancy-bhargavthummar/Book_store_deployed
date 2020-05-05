# frozen_string_literal: true

class AddIsbnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :isbn, :integer
  end
end
