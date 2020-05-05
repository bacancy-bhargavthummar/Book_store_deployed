# frozen_string_literal: true

module BooksHelper

  # def your_upload_graph(books)
  #   if books.present?
  #     @book_id_array = []
  #     @book_qty_array = []
  #     @book_hash = Hash.new

  #     books.each {|id, qty| @book_id_array.push(id); @book_qty_array.push(qty) }
  #     @book_name = Book.where(id: [@book_id_array]).pluck(:name)
  #     @book_name.each_with_index {|k,i| @book_hash[k] = @book_qty_array[i]}
  #     return @book_hash

  #   else
  #     Book.joins(:book_sellers).where('book_sellers.seller_id = ?', current_user).pluck('name, selling_quantity')
  #   end
  # end

end
