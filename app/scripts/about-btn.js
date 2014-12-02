$(document).ready(function() {
  $("#go-to-about").click(function( event ) {
    event.preventDefault();
      $('html, body').animate({
          scrollTop: $("#about").offset().top
      }, 1000);
  });
});