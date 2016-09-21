class Api::V1::CommentsController < ApplicationController

  def index
    render json: Comment.all #make sure to scope to a single review
  end

  def create
    binding.pry
    comment = Comment.new(comment_params)
    comment.user = current_user
    review = comment_params[:review_id]
    if comment.save
      CommentMailer.new_comment(comment).deliver_later

      binding.pry

      render json: { comment_id: comment.id }.to_json #set up as json object, status: :created, location: api_v1_comments_path
    else
      render json: :nothing, status: :not_found
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description, :review_id)
  end

end
