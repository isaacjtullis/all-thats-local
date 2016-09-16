class ReviewsController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(review_id: @review.id)
  end

  def edit
    @review = Review.find(params[:id])
    if @review.user_id != current_user.id && !current_user.admin?
      flash[:notice] = "You cannot edit a review you did not write."
      redirect_to @review
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = 'Review was successfully updated.'
      redirect_to @review
    else
      flash[:notice] = 'Review as not updated'
      render :'reviews/edit'
    end
  end

  def create
    #binding.pry
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "Your review was saved!"
      redirect_to @review
    else
      flash[:alert] = "Your review was not saved!"
      #@cusine = Review::CUSINE
      #@price = Review::PRICE
      render :new
    end
  end

  def destroy
    review = Review.find(params[:id])
    if review.user_id != current_user.id && !current_user.admin?
      flash[:notice] = "You cannot delete a question you did not write."
      redirect_to review_path
    else
      review.destroy
      flash[:notice] = "Review was deleted"
      redirect_to reviews_path
    end
  end


  protected

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def require_login
    unless current_user
      flash[:notice] = "You must be logged in to make changes!"
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :name,
      :review,
      :cusine,
      :price
    )
  end
end
