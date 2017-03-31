class WelcomeController < ApplicationController
  def index
    @albums = Piece.best_albums
    @books = Piece.best_books
    @movies = Piece.best_movies
    @best_piece = Piece.order(vote_count: :desc).first
  end

  def login_form
  end

  def login
    username = params[:username]
    if username and user = User.find_by(username: username)
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in as existing user #{user.username}"
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "Successfully created new user #{user.username} with ID #{user.id}"
      else
        flash[:status] = :failure
        flash[:result_text] = "Could not log in"
        flash[:messages] = user.errors.messages
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
