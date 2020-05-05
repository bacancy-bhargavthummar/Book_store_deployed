# frozen_string_literal: true

json.extract! book, :id, :book_name, :book_description, :book_author, :book_price, :book_qty, :user_id, :category_id, :created_at, :updated_at
json.url book_url(book, format: :json)
