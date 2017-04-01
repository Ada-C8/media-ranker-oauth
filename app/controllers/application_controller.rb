class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

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
      if piece and piece.id
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
      if piece and piece.id
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
      if piece and piece.id
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
  helper_method :media_path

  def upvote_path(piece)
    if piece.category == "album"
      upvote_album_path(piece)
    elsif piece.category == "book"
      upvote_book_path(piece)
    elsif piece.category == "movie"
      upvote_movie_path(piece)
    end
  end
  helper_method :upvote_path

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private
  def find_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
  end
end
