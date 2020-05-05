# frozen_string_literal: true

class AddSellingQuantityInBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :selling_quantity, :integer, default: 0
  end
end
