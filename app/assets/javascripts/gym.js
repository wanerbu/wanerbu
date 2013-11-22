//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function searchItem(field,value){
  document.getElementById(field).value = value;
  setselect(field,value);
  var sportid = document.getElementById("sportid").value;
  var areaid = document.getElementById("areaid").value;
  jQuery.get('search/' + sportid + '/' + areaid,
      function(data){
        $('#gymListArea').hide();    
        $("#gymListAreaBySearch").html(data);
      });
}

function setselect(field,value){
  var elements = document.getElementById("fid"+ field);
  for (var i = 0; i < elements.children.length ; i++ )
  {
    if (elements.children[i].name == value){
      elements.children[i].setAttribute("class","select");
    } else {
      elements.children[i].removeAttribute("class");
    }
  }
}

