class WelcomeController < ApplicationController
  def index
    @albums = Piece.best_albums
    @books = Piece.best_books
    @movies = Piece.best_movies
  end

  def login_form
  end

  def login
    username = params[:username]
    if username and user = User.find_by(username: username)
      session[:user_id] = user.id
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = user.id
      else
        flash[:error_text] = "Could not log in"
        flash[:messages] = user.errors.messages
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
