$( ".adventure" ).click(function() {
  if ($(".form-signin").is(":visible")) {
    $(".form-signin").hide();
  } else {
    $(".form-signin").slideDown();
  }
});
