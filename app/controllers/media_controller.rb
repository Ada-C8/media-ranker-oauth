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
  end

  def edit
  end

  def update
  end

  def delete
  end

private
  def media_params
    params.require(piece).permit(:title, :category, :creator, :description, :publication_date)
  end


end
