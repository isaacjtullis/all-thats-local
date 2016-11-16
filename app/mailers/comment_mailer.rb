class CommentMailer < ApplicationMailer
  def new_comment(comment)
    @user_who_commented = User.find(comment.user_id)
    @review = Review.find(comment.review_id)
    @author_of_review = User.find(@review.user_id)

    mail(
    to: @author_of_review.email,
    subject: "New Review for #{@review.name}"
    )
  end

end
