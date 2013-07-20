//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(function(){
    $("#gym_province_id").change(function() {
      var province_id = $('select#gym_province_id :selected').val();

      if(province_id == "") province_id ="0";

      jQuery.get('get_cities_by_province_id/' + province_id,
          function(data){
              $("#cities").html(data);
                })
       return false;
    });  
});
