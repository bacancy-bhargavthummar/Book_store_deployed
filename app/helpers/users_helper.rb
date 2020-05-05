# frozen_string_literal: true

module UsersHelper

  def all_book_selling_quantity_graph
    Book.pluck(:name, :selling_quantity)
  end
  
end
