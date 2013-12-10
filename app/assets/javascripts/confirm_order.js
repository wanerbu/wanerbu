//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(function(){
  //页面刷新时加载时间计时处理 
  var timer;
  var sec = 0;
  var min = 1;//最大分钟数
  var showtimeout = document.getElementById("showtimeout");
  showtimeout.innerHTML = '<b class=\'RemainMS\'>'+ min +'</b>'+'分钟' + '<b class=\'RemainMS\'>' + sec +'</b>'+ '秒';
  timer=setInterval(function(){
    sec--;
    if(sec < 0){
      sec = 59;
      min--;
    }
    if (min >= 0 && sec >=0 ){
      showtimeout.innerHTML = '<b class=\'RemainMS\'>'+ min +'</b>'+'分钟' + '<b class=\'RemainMS\'>' + sec +'</b>'+ '秒';
    }else{
      showtimeout.innerHTML =  '订单已超时';
      clearInterval(timer);
      document.getElementById("order_status").value = "92";
      //更新订单状态为超时
      order_id = document.getElementById("order_id").value;
      $.get('update_order_to_timeout/' + order_id);
      //回到场次选择页面
      relink();
    }
  },1000);
});
function validateform(){
  var order_status =  document.getElementById("order_status").value;
  r = false;
  if (order_status == "92"){
    relink();
  } else {//提交至支付页面
    r = true;
  }
  return r;
}
function relink(){
  if (confirm('对不起！您的订单已超时,请重新选择')){
    var court_id = document.getElementById("court_id").value;
    var date = document.getElementById("date").value;
    var url = '/gym/reserve/'+ court_id + '/' + date;
    window.open(url,"_top");
  }
}
