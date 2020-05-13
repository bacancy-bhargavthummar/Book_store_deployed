module FavoritesHelper
  def is_favorite?(book,user)
    if user.favorites.find_by(book_id: book.id)
      return  "Remove from Favourite"
    else
      return "Add to Favourite"
    end
  end
end
