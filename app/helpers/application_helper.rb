module ApplicationHelper
  # DPR: Hmmmm, mixing these two syntaxes seems wrong, but it's the only
  # way I could figure to get the optional positional argument (piece)
  # to play nicely with the optional named arguments (category and form)
  def media_path(piece=nil, category: nil, form: false)
    if !category and piece
      category = piece.category
    elsif !category and @media_category
      category = @media_category
    else
      raise ArgumentError.new "No media category provided"
    end

    if category == "album"
      if piece
        if form
          return edit_album_path(piece)
        else
          return album_path(piece)
        end
      else
        if form
          return new_album_path
        else
          return albums_path
        end
      end

    elsif category == "book"
      if piece
        if form
          return edit_book_path(piece)
        else
          return book_path(piece)
        end
      else
        if form
          return new_book_path
        else
          return books_path
        end
      end

    elsif category == "movie"
      if piece
        if form
          return edit_movie_path(piece)
        else
          return movie_path(piece)
        end
      else
        if form
          return new_movie_path
        else
          return movies_path
        end
      end
    end
  end
end
