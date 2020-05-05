# frozen_string_literal: true

class ChangeColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :books, :book_name, :name
    rename_column :books, :book_description, :description
    rename_column :books, :book_author, :author
    rename_column :books, :book_price, :price
    rename_column :books, :book_qty, :total_qty
    rename_column :categories, :category_name, :name
    rename_column :users, :user_name, :name
  end
end
