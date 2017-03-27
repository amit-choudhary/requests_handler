var Comment = function(commentBox) {
  this.commentBox = commentBox;
}

Comment.prototype = {
  init: function(){
    this.submitOnEnter();
  },
  submitOnEnter: function() {
    var _this = this;
    this.commentBox.keypress(function(event) {
      if (event.which == 13  && !event.shiftKey) {
        event.preventDefault();
        $.ajax({
          type: "POST",
          url: $('form').attr('action'),
          data: $('form').serialize(),
          success: function(data, textStatus, jqXHR) {
            $('form')[0].reset();
            var newComment = _this.getCommentBox().append(_this.getContentDiv(data['name'], data['content']))
            $('div#form-comment-div').after(newComment);
          },
          error: function() {
            $('div.comment-div div#flash-div').show();
          }
        });
      }
    });
  },
  getCommentBox: function() {
    return $('<div>').addClass('row comment-box');
  },
  getContentDiv: function(name, content) {
    contentDiv = $('<div>').addClass('col-lg-11 col-md-8')
      .append($('<h4>').addClass('user-name').text(name))
      .append($('<p>').addClass('comment-time').text('just now'))
      .append($('<div>').addClass('comment-text').text(content));
    return contentDiv;
  }
}

$(function(){
  var commenting = new Comment($("#content"));
  commenting.init();
});
