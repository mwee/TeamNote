// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

$(function() {
  if ($(".notes").length > 0) {
    setTimeout(updateNotes, 2000);
  }
});

function updateNotes () {
  var user_id = $(".notes").attr("data-id");

  $.getScript("/notes.js?user_id=" + user_id);
  setTimeout(updateNotes, 2000);
}