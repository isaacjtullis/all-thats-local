var newCommentCreator = function(commentAttributes, reviewAttributes, commentidAttributes, divId) {
  return {
    comment: commentAttributes,
    review: reviewAttributes,
    review_id: commentidAttributes,
    div: $(divId),
    create: function() {
      var commentCreatorObject = this;
      var request = $.ajax({
        method: "POST",
        url: "/api/v1/comments",
        data: { comment: { description: commentCreatorObject.comment, review_id: commentCreatorObject.review, comment_id: commentCreatorObject.comment_id } }
      });

      request.done(function(comment_id) {
        debugger
        commentCreatorObject.setFlash("notice", "YOUR COMMENT IS COMMENTED!!");
        commentCreatorObject.append(comment_id["comment_id"]); // the () invokes the function
        commentCreatorObject.clearForm();
      });

      request.error(function() {
        commentCreatorObject.setFlash("error", "There was a problem with your comment.");
      });
    },
    setFlash: function(type, message) {
      $("div.flash").remove();
      var flash = $("<div>", { "class": "flash flash-" + type }).text(message);
      $("body").prepend(flash);
    },
    clearForm: function(){
      $('#comment_description').val("");
      $("input[value='Create Comment']").removeAttr('disabled');
    },
    append: function(comment_id) {
      debugger
      var commentId = comment_id
      var edit_comment_url_string = '/reviews/' + comment_id + '/comments/' + this.review + '/edit'
      var delete_comment_url_string = '/reviews/' + comment_id + '/comments' + this.review + '/delete'
      var newComment = "<li>" + "<p>" + this.comment + "<a href=" + edit_comment_url_string + ">" + 'Edit Comment' + "</a>" + "</p>"  +
      "<p>" + "<a href=" + delete_comment_url_string + ">" + 'Delete Comments' + "</a>" + "</p>" + "</li>"
      $('#comments').append(newComment);
    }
  }
};

//'<a href="'/reviews/' + comment_id +  '/comments/' + this.review +  '/edit' + ">'

//"<a href='reviews'" + this.comment_id + 'comments' + this.review + 'edit'> + 'Edit Comment' + "</a>" + "</p>" +
//"<p>" + "<a href=''" + this.comment +">this</a>"  +"</p>" +
//"<p>" + "<a href='espn.com'>Delete</a>" + "</p>" +


//---

//   <p><%= comment.description %><%= link_to ' Edit Comment', edit_review_comment_path(comment.id) %></p>
//   <p><%= link_to ' Delete Comment', review_comment_path(comment), method: :delete, data: {confirm: 'Are you sure you want to delete this comment?'}%></p>
// </li>
