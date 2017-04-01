class MediaController < ApplicationController
  before_action :media_category
  before_action :require_piece, except: [:index, :new, :create]

  def index
    @media = Piece.where(category: @media_category).order(vote_count: :desc)
  end

  def new
    @piece = Piece.new(category: @media_category)
  end

  def create
    piece = Piece.new(media_params)
    if piece.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created #{@media_category} #{piece.id}"
      redirect_to media_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@media_category}"
      flash[:messages] = piece.errors.messages
    end
  end

  def show
    @votes = @piece.votes.order(created_at: :desc)
  end

  def edit
  end

  def update
    @piece.update_attributes(media_params)
    if @piece.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated #{@media_category} #{@piece.id}"
      redirect_to media_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not update #{@media_category}"
      flash[:messages] = @piece.errors.messages
    end
  end

  def destroy
    @piece.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@media_category} #{@piece.id}"
    redirect_to media_path
  end

  def upvote
    # Most of these varied paths end in failure
    # Something tragically beautiful about the whole thing
    flash[:status] = :failure
    if @login_user
      vote = Vote.new(user: @login_user, piece: @piece)
      if vote.save
        flash[:status] = :success
        flash[:result_text] = "Successfully upvoted!"
      else
        flash[:result_text] = "Could not upvote"
        flash[:messages] = vote.errors.messages
      end
    else
      flash[:result_text] = "You must log in to do that"
    end

    # Refresh the page to show either the updated vote count
    # or the error message
    redirect_back fallback_location: media_path
  end

private
  def media_params
    params.require(:piece).permit(:title, :category, :creator, :description, :publication_year)
  end

  def require_piece
    @piece = Piece.find_by(id: params[:id])
    render_404 unless @piece

    render_404 unless @piece.category == @media_category
  end
end
