class WorksController < ApplicationController
  # We should always be able to tell what category
  # of work we're dealing with
  before_action :category_from_url, only: [:index, :new, :create]
  before_action :category_from_work, except: [:index, :new, :create]

  def index
    @media = Work.by_category(@media_category).order(vote_count: :desc)
    render :index
  end

  def new
    @work = Work.new(category: @media_category)
  end

  def create
    @work = Work.new(media_params)
    if @work.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created #{@media_category.singularize} #{@work.id}"
      redirect_to works_path(@media_category)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not create #{@media_category.singularize}"
      flash[:messages] = @work.errors.messages
      render :new
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
      flash[:result_text] = "Successfully updated #{@media_category.singularize} #{@work.id}"
      redirect_to works_path(@media_category)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not update #{@media_category.singularize}"
      flash[:messages] = @work.errors.messages
      render :edit
    end
  end

  def destroy
    @work.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@media_category} #{@work.id}"
    redirect_to works_path(@media_category)
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
    redirect_back fallback_location: works_path(@media_category)
  end

private
  def media_params
    params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

  def category_from_url
    @media_category = params[:category].downcase.pluralize
  end

  def category_from_work
    @work = Work.find_by(id: params[:id])
    render_404 unless @work
    @media_category = @work.category.downcase.pluralize
  end
end
