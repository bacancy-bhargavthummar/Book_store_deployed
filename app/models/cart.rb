# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user

  def add_product(book, qty = 0)
    current_item = line_items.find_by(book_id: book.id)
    if current_item && qty.to_i == 0
      if book.total_qty > current_item.quantity && current_item.quantity < 10
        current_item.quantity += 1
      end
    elsif current_item && qty.to_i > 0
      book = Book.find(book.id)
      current_item.quantity = 0
      current_item.quantity += if book.total_qty >= qty.to_i
                                 qty.to_i
                               else
                                 book.total_qty
                               end
    else
      current_item = line_items.build(book_id: book.id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
    # line_items.to_a.sum { |item| item.total_price }
  end
end
