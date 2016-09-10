class ReviewsController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :new, :create]
  before_action :require_login, except: [:index, :show]

  def index
  end

  def new
    @review = Review.new
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
end
