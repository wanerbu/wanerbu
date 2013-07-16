//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(function(){
    $("#price_rule_rule_type").change(function() {
      var price_rule_type = $('select#price_rule_rule_type :selected').val();
      if (price_rule_type == '01'){
         $('#select_date_price_rule').show();    
         $('#select_week_price_rule').hide();    
       }else{
         $('#select_date_price_rule').hide();    
         $('#select_week_price_rule').show();    
       }
    });  
    $("#reservation_rule_rule_type").change(function() {
      var reservation_rule_type = $('select#reservation_rule_rule_type :selected').val();
      if (reservation_rule_type == '01'){
         $('#select_date_reservation_rule').show();    
         $('#select_week_reservation_rule').hide();    
       }else{
         $('#select_date_reservation_rule').hide();    
         $('#select_week_reservation_rule').show();    
       }
    });  
});
