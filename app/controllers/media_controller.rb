class MediaController < ApplicationController
  before_action :media_category

  def index
    @media = Piece.where(category: @media_category)
  end

  def new
    @piece = Piece.new(category: @media_category)
  end

  def create
    piece = Piece.new(media_params)
    if piece.save
      redirect_to media_path
    else
      flash[:error_text] = "Could not create #{@media_category}"
      flash[:messages] = piece.errors.messages
    end
  end

  def show
    @media = Piece.find(params[:id])
    if @media.category != @media_category
      # TODO DPR: do something reasonable
      raise ArgumentError "Wrong media type for this controller!"
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def upvote
    if @user
      piece = Piece.find_by(id: params[:id])
      if piece
        vote = Vote.new(user: @user, piece: piece)
        if vote.save

        else
          flash[:error_text] = "Could not upvote"
          flash[:messages] = vote.errors.messages
        end
      else
        flash[:error_text] = "No media found with ID #{params[:id]}"
      end
    else
      flash[:error_text] = "You must log in to do that"
    end

    # Refresh the page to show either the updated vote count
    # or the error message
    redirect_back fallback_location: media_path
  end

private
  def media_params
    params.require(piece).permit(:title, :category, :creator, :description, :publication_date)
  end


end
