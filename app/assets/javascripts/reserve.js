//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function searchgame(court_id,date){
  jQuery.get('/gym/searchgame/' + court_id + '/' + date ,
      function(data){
        $('#gameList').hide();    
        $("#gameListBySearch").html(data);
      });
}
