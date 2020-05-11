# frozen_string_literal: true

module UsersHelper

  def all_book_selling_quantity_graph
    Book.order(selling_quantity: :desc).pluck(:name, :selling_quantity).first(20) 
  end
  
end
