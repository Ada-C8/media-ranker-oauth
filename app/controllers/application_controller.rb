class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  # DPR: Hmmmm, mixing these two syntaxes seems wrong, but it's the only
  # way I could figure to get the optional positional argument (work)
  # to play nicely with the optional named arguments (category and form)
  def media_path(work=nil, category: nil, form: false)
    if !category and work
      category = work.category
    elsif !category and @media_category
      category = @media_category
    else
      raise ArgumentError.new "No media category provided"
    end

    if category == "album"
      if work and work.id
        if form
          return edit_album_path(work)
        else
          return album_path(work)
        end
      else
        if form
          return new_album_path
        else
          return albums_path
        end
      end

    elsif category == "book"
      if work and work.id
        if form
          return edit_book_path(work)
        else
          return book_path(work)
        end
      else
        if form
          return new_book_path
        else
          return books_path
        end
      end

    elsif category == "movie"
      if work and work.id
        if form
          return edit_movie_path(work)
        else
          return movie_path(work)
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

  # def upvote_path(work)
  #   if work.category == "album"
  #     upvote_album_path(work)
  #   elsif work.category == "book"
  #     upvote_book_path(work)
  #   elsif work.category == "movie"
  #     upvote_movie_path(work)
  #   end
  # end
  # helper_method :upvote_path

  def render_404
    # DPR: supposedly this will actually render a 404 page in production
    raise ActionController::RoutingError.new('Not Found')
  end

private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
