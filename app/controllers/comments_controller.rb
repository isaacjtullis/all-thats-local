class CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.likes_count = 0
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

  def upvote
    @comment = Comment.find(params[:id])
    vote = @comment.favorites.where(user_id: current_user.id).last
    if current_user.has_voted_on?(@comment)
      @comment.favorites.create(user_id: current_user.id, vote: "upvote").save
      upvote = @comment[:likes_count] += 1
      @comment.save
      flash[:notice] = "Thank you for upvoting!"
      redirect_to review_path(@comment.review_id)
    elsif !current_user.has_voted_on?(@comment) && vote.vote == 'downvote'
      vote.destroy
      @comment.favorites.create(user_id: current_user.id, vote: 'upvote').save
      @comment[:likes_count] += 2
      @comment.save
      flash[:notice] = "Thank you for upvoting!"
      redirect_to review_path(@comment.review_id)
    else
      flash[:notice] = "You have already upvoted this!"
      redirect_to review_path(@comment.review_id)
    end
  end

  def downvote
    @comment = Comment.find(params[:id])
    review = @comment.review_id
    vote = @comment.favorites.where(user_id: current_user.id).last
    if current_user.has_voted_on?(@comment)
      @comment.favorites.create(user_id: current_user.id, vote: 'downvote').save
      @comment[:likes_count] -= 1
      @comment.save
      flash[:notice] = "You have successfully downvoted!"
      redirect_to review_path(review)
    elsif !current_user.has_voted_on?(@comment) && vote.vote == 'upvote'
      vote.destroy
      @comment.favorites.create(user_id: current_user.id, vote: 'downvote').save
      @comment[:likes_count] -= 2
      @comment.save
      flash[:notice] = 'You have successfully downvoted!'
      redirect_to review_path(review)
    else
      flash[:notice] = "You have already downvoted this!"
      redirect_to review_path(review)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :review_id, :likes_count)
  end
end
