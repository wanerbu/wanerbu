//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(function(){
  //页面刷新时 
      var city_id = $('select#gym_city_id :selected').val();

      if(city_id == "") city_id ="0";

      jQuery.get('get_areas_by_city_id/' + city_id,
          function(data){
              $("#areas").html(data);
                });
  //用户选择时
  $("#gym_city_id").change(function() {
      var city_id = $('select#gym_city_id :selected').val();

      if(city_id == "") city_id ="0";

      jQuery.get('get_areas_by_city_id/' + city_id,
          function(data){
              $("#areas").html(data);
                })
       return false;
    });  
});
