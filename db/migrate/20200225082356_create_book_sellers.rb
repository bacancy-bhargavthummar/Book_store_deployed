# frozen_string_literal: true

class CreateBookSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :book_sellers do |t|
      t.references :book, null: false, foreign_key: true
      t.references :seller, references: :users
      t.timestamps
    end
  end
end
