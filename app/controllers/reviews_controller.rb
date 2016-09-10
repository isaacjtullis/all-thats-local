class ReviewsController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create]
  before_action :require_login, except: [:index, :show]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    #@cusine = Review::CUSINE
    #@price = Review::PRICE
  end

  def show
    @review = Review.find(params[:id])
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
