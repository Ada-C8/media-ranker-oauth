module MediaHelper
  def media_path(piece)
    return nil unless piece
    return album_path(piece) if piece.category == "album"
    return book_path(piece) if piece.category == "book"
    return movie_path(piece) if piece.category == "movie"
  end
end
