//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function searchItem(field,value1,value2){
  document.getElementById(field).value = value1;
  setSelect(field,value1);
  setChose(field,value2);
  requestSearch();
}
function searchKey(){

  var keyword =  document.getElementById("keywordinput").value;
  document.getElementById("keyword").value = keyword;

  $('#chosetxt').show();
  element = document.getElementById("chosekeyword");
  $('#chosekeyword').show();
  element.innerHTML = keyword+'&times';  
  requestSearch();
}
function searchForReserve(value){
  document.getElementById("reservekey").value = value;
  if (value == 'all'){
    document.getElementById("openonlygym").removeAttribute("class");
    document.getElementById("allgym").setAttribute("class","active");
  }
  if (value == 'openonly'){
    document.getElementById("allgym").removeAttribute("class");
    document.getElementById("openonlygym").setAttribute("class","active");
  }

  requestSearch();
}
function sortBy(value){
  document.getElementById("sortkey").value = value;
  document.getElementById("showsort").innerHTML = document.getElementById(value).innerHTML + "<span class='caret'></span>";
  requestSearch();
}
function remove(field){
  document.getElementById(field).value = 'all';
  if (field != 'keyword'){
    var elements = document.getElementById("fid"+ field);
    for (var i = 0; i < elements.children.length ; i++ )
    {
      elements.children[i].removeAttribute("class");
    }
  }else{
    document.getElementById("keywordinput").value = " ";
    document.getElementById("keywordinput").placeholder= "请输入搜索关键词";
  }
  removeChose(field);
  requestSearch();
}

function setSelect(field,value){
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
function setChose(field,value2){
  $('#chosetxt').show();
  element = document.getElementById("chose"+field);
  $('#chose'+field).show();
  element.innerHTML = value2+'&times';  
}
function removeChose(field){
  $('#chose'+field).hide();
  var sportid = document.getElementById("sportid").value;
  var areaid = document.getElementById("areaid").value;
  var keyword = document.getElementById("keyword").value;
  if ((sportid=="all" ) && (areaid=="all") && (keyword == "all")){
    $('#chosetxt').hide();
  }
}
function requestSearch(){
  var sportid = document.getElementById("sportid").value;
  var areaid = document.getElementById("areaid").value;
  var keyword = document.getElementById("keyword").value;
  var reservekey = document.getElementById("reservekey").value;
  var sortkey = document.getElementById("sortkey").value;
  jQuery.get('search/' + sportid + '/' + areaid + '/' +  keyword + '/' +  reservekey + '/' +  sortkey,
      function(data){
        $('#gymListArea').hide();    
        $("#gymListAreaBySearch").html(data);
        changehref(); 
      });
}
jQuery(function($) {
  //页面刷新时
  changehref(); 
})
function page(value){
  var sportid = document.getElementById("sportid").value;
  var areaid = document.getElementById("areaid").value;
  var keyword = document.getElementById("keyword").value;
  var reservekey = document.getElementById("reservekey").value;
  var sortkey = document.getElementById("sortkey").value;
  jQuery.get('search/' + sportid + '/' + areaid + '/' +  keyword + '/' +  reservekey + '/' +  sortkey + '?page=' + value,
      function(data){
        $('#gymListArea').hide();    
        $("#gymListAreaBySearch").html(data);
        changehref(); 
      });
}
function changehref(){
  var page = "";
  $(".pagination a[href^='/gym']")
    .each(function()
        { 
          page = this.href.substr(this.href.indexOf("=") + 1);
          this.href = "javascript:page('" + page + "')";
        });
}
function toOneGym(value){
  var sportid = document.getElementById("sportid").value;
  var url = 'one_gym/'+ value + '/' + sportid;
  window.open(url,"_blank");
}
