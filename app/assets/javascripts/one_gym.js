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
function toOneCourt(court_id,date){
  var url = '/gym/reserve/'+ court_id + '/' + date;
  window.open(url,"_blank");
}
function tabs(clicka,searchtype){
  var elements = document.getElementById('pattern');
  for (var i = 0; i < elements.children.length ; i++ )
  {
    elements.children[i].removeAttribute("class");
  }
  clicka.setAttribute("class","select");
  document.getElementById('searchtype').value = searchtype;
}
$(document).ready(function(){
  $("#1").mouseover(function() {
    set_class("1");
  });
  $("#1").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#1").click(function() {
    $("#score").attr("value","1");
  });

  $("#2").mouseover(function() {
    set_class("2");
  });
  $("#2").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#2").click(function() {
    $("#score").attr("value","2");
  });

  $("#3").mouseover(function() {
    set_class("3");
  });
  $("#3").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#3").click(function() {
    $("#score").attr("value","3");
  });

  $("#4").mouseover(function() {
    set_class("4");
  });
  $("#4").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#4").click(function() {
    $("#score").attr("value","4");
  });

  $("#5").mouseover(function() {
    set_class("5");
  });
  $("#5").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#5").click(function() {
    $("#score").attr("value","5");
  });

  $("#6").mouseover(function() {
    set_class("6");
  });
  $("#6").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#6").click(function() {
    $("#score").attr("value","6");
  });

  $("#7").mouseover(function() {
    set_class("7");
  });
  $("#7").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#7").click(function() {
    $("#score").attr("value","7");
  });

  $("#8").mouseover(function() {
    set_class("8");
  });
  $("#8").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#8").click(function() {
    $("#score").attr("value","8");
  });

  $("#9").mouseover(function() {
    set_class("9");
  });
  $("#9").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#9").click(function() {
    $("#score").attr("value","9");
  });

  $("#10").mouseover(function() {
    set_class("10");
  });
  $("#10").mouseleave(function() {
    var score = $("#score").val();
    set_class(score);
  });
  $("#10").click(function() {
    $("#score").attr("value","10");
  });

  $("#sub_comment").click(function() {
    var user_id =  document.getElementById("user_id").value;
    if (user_id == " "){
      $('#loginModal').modal('toggle');
    }else{
      var score = $("#score").val();
      if(score == ""){
        alert("请选择一个分数！");
      }else{
        var comment = $("#comment").val();
        if (comment == ""){
          alert("请输入评论内容！");
        }else{
          $.ajax({
            url: '/gym/submit_comment',
            type: 'post',
            async: false,
            data: $('form#commentform').serialize(),
            success:function(data) {
              $("#gym_comments_list").html(data);
              changehref();//该默认的pagination的href使其异步请求翻页 
              document.getElementById("comment").value = "";
              document.getElementById("remain").innerHTML = "140";
            }
          });
        }
      }
    }
  });

  $("#comment").keydown(function() {
    gbcount();
  });

  $("#comment").keyup(function() {
    gbcount();
  });

});
//设置评分星星的样式
function set_class(s){
  score = s * 1;
  for (var i =1 ; i <=10 ; i++){
    if(i <= score){
      if(i%2 == 0){
        $("#"+i).attr("class","on");
      }else{
        $("#"+i).attr("class","half");
      }
    }else{
      if(i%2 == 0){
        $("#"+i).attr("class","no");
      }else{
        $("#"+i).attr("class","");
      }
    }
  }
  smp = document.getElementById("scoreMarkPoint");
  smd = document.getElementById("scoreMarkDesc"); 
  if(s == ""){
    smp.innerHTML = "";
    smd.innerHTML = "";
  }else{
    ele = document.getElementById(s);
    var lang =  ele.getAttribute("lang");
    smp.innerHTML = s + ".0";
    smd.innerHTML = lang;
  }
}
//评论剩余字数统计
function gbcount(){
  var max = 140;
  var remain = 0;
  var message =  document.getElementById("comment");
  var remain_b =  document.getElementById("remain");
  if (message.value.length > max) { 
    message.value = message.value.substring(0,max); 
    remain = 0; 
    alert("评论内容不能超过 140 个字!"); 
  } 
  else { 
    remain = max - message.value.length; 
  } 
  remain_b.innerHTML = remain;
} 
function showComment(){
  window.location.hash = "#location_comment";
}

jQuery(function($) {
  //页面刷新时
  changehref(); 
})
function page(value){
  var gym_id = document.getElementById("gym_id").value;
  jQuery.get('/gym/search_comment/' + gym_id + '?page=' + value,
      function(data){
        $("#gym_comments_list").html(data);
        changehref();//该默认的pagination的href使其异步请求翻页 
        document.getElementById("comment").value = "";
        document.getElementById("remain").innerHTML = "140";
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
