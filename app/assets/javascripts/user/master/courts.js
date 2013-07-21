//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery(function($) {
  //页面刷新时 
    var sport = $('select#court_sport_id :selected').val();
    if(sport == "") sport="0";
    jQuery.get('edit_court_properties_select/' + sport,
    function(data){
     $("#courtProperties").html(data);
                  });

  //用户选择时
  $("#court_sport_id").change(function() {
    var sport = $('select#court_sport_id :selected').val();
    if(sport == "") sport="0";
    jQuery.get('edit_court_properties_select/' + sport,
    function(data){
     $("#courtProperties").html(data);
                  })
   return false;
   });
 })
