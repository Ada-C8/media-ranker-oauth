class WorksController < ApplicationController
  # before_action :media_category
  before_action :require_work, except: [:index, :new, :create]

  def index
    @media_category = params[:category]
    @media = Work.by_category(params[:category]).order(vote_count: :desc)
    render :index
  end

  def new
    @work = Work.new(category: @media_category)
  end

  def create
    work = Work.new(media_params)
    if work.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created #{@media_category} #{work.id}"
      redirect_to media_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@media_category}"
      flash[:messages] = work.errors.messages
    end
  end

  def show
    @votes = @work.votes.order(created_at: :desc)
  end

  def edit
  end

  def update
    @work.update_attributes(media_params)
    if @work.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated #{@media_category} #{@work.id}"
      redirect_to media_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not update #{@media_category}"
      flash[:messages] = @work.errors.messages
    end
  end

  def destroy
    @work.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@media_category} #{@work.id}"
    redirect_to media_path
  end

  def upvote
    # Most of these varied paths end in failure
    # Something tragically beautiful about the whole thing
    flash[:status] = :failure
    if @login_user
      vote = Vote.new(user: @login_user, work: @work)
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
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

  def require_work
    @work = Work.find_by(id: params[:id])
    @media_category = @work.category.downcase.pluralize
    render_404 unless @work
  end
end
