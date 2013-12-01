//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function getcourt(field,value1){
  document.getElementById(field).value = value1;
  requestSearch();
}
function requestSearch(){
  var sportid = document.getElementById("sportid").value;
  var reservationtype = document.getElementById("reservationtype").value;
  var gymid = document.getElementById("gymid").value;
  jQuery.get('/gym/getcourt/' + gymid + '/' + sportid + '/' + reservationtype ,
      function(data){
        $('#reserveList').hide();    
        $("#reserveListBySearch").html(data);
      });
}
