# frozen_string_literal: true

module ApplicationHelper

  def individual_book_selling_graph(book)
    LineItem.group_by_hour(:created_at).having("book_id = ?", book.id).sum(:quantity)
  end

end
