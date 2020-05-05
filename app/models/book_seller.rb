# frozen_string_literal: true

class BookSeller < ApplicationRecord
  belongs_to :book
  belongs_to :seller, class_name: 'User', foreign_key: :seller_id

  scope :finding, ->(s) { BookSeller.joins(:book, :seller).where('books.name LIKE ? OR users.name LIKE ? OR books.isbn LIKE ? ', "%#{s}%", "%#{s}%", "%#{s}%") }
end
