// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(function() {
  $("#products_search input").keyup(function() {
    $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
    return false;
  });
  $("#delete_all").click(function(e){
   e.preventDefault();
   //show loading gif
   $('.sk-circle').show()
   // disable_button & prevent additional clicks from firing until response recieved
   $.ajax({
    url: "/delete_all",
    type: "POST",
    data: 'anything',
    success: function () { $('.sk-circle').hide()},
    error: function () {$('.sk-circle').hide()}, // TODO flash error message
    });
  });
  $("#fetch_more").click(function(e){
   e.preventDefault();
   //show loading gif
   $('.sk-circle').show()
   // disable_button & prevent additional clicks from firing until response recieved
   $.ajax({
    url: "/fetch_more",
    type: "POST",
    data: 'anything',
    success: function (data) {
      $('.sk-circle').hide();
      },
    error: function (data) {
      $('.sk-circle').hide()
    }, // TODO flash error messages
    });
  });
});