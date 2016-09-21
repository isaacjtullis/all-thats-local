var newCommentForm = function(formId) {
    return {
    element: $(formId),
    description: function() {
      return this.element.find("#comment_description").val();
    },
    review: function() {
      return this.element.find("#comment_review_id").val();
    },
    commentId: function() {
      var postPath = this.element.attr("action");
      var regex = /\/reviews\/(\d+)\/comments/;
      var matches = postPath.match(regex);
      var result;
      if(matches.length === 2) {
        result = matches[1];
      }
      return result
    },
    attributes: function() {
      var result = {
        description: this.description(),
        review: this.review(),
        comment_id: this.commentId()
      }
      return result;
    }
  }
}
