class CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @comment = Comment.new(comment_params)
    @comment.review_id = @review.id
    @comment.user_id = current_user.id

    if @comment.save
      binding.pry
      CommentMailer.new_comment(@comment).deliver_later

      flash[:notice] = "Your comment was saved!"
      redirect_to review_path(@review)
    else
      flash[:notice] = "Comment was not saved!"
      @id = params[:review_id]
      redirect_to review_path(@review)
    end
  end

  def edit
    @comment = Comment.find(params[:review_id])
    @review = Review.find(@comment.review_id)
    if @comment.user_id != current_user.id && !current_user.admin?
      flash[:notice] = "You cannot review someone elses comment"
      redirect_to @comment
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @review = Review.find(params[:review_id])
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to review_path(@review)
    else
      flash[:notice] = 'Comment did not save'
      render :'reviews/show'
    end
  end

  def destroy
    comment = Comment.find(params[:review_id])
    review = Review.find(params[:id])
    if comment.user_id != current_user.id && !current_user.admin?
      flash[:notice] = "You cannot delete a comment you did not make!"
      redirect_to review_path(review)
    else
      comment.destroy
      flash[:notice] = "Comment was deleted!"
      redirect_to review_path(review)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end
