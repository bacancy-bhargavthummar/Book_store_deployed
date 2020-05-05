$(document).ready(function(){
  $(".my_comment_form").submit(function(){
    var body = $('#comment_body').val();

    if (body.length < 1) {
        alert('comment field is empty.');
        return false;
    }
  });
});