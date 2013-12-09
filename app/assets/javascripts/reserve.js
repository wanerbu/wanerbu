//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function searchgame(court_id,date){
  jQuery.get('/gym/searchgame/' + court_id + '/' + date ,
      function(data){
        var reserveDiv =  document.getElementById('reservediv');
        var gameListDiv = document.getElementById('gameList');
        if (gameListDiv != null) {
          reserveDiv.removeChild(gameListDiv);
        }
        $("#gameListBySearch").html(data);
      });
}
function select(id,game_id){
  var user_id =  document.getElementById("user_id").value;
  if (user_id == " "){
    $('#loginModal').modal('toggle');
  }else{
    var MAX_RESERVATION_NUM = 4;
    var element = document.getElementById(id);
    var price = element.getAttribute("price") * 1;
    var start_time = element.getAttribute("start_time");
    var end_time = element.getAttribute("end_time");
    var timesInput =  document.getElementById("timesInput").value * 1;
    var priceInput =  document.getElementById("priceInput").value * 1;
    if (element.getAttribute("class") == "checkSeat"){//已选中
      element.setAttribute("class","hasSeat");//取消选中
      document.getElementById("timesInput").value = timesInput - 1;
      document.getElementById("priceInput").value = priceInput - price;
      if (timesInput == 1){
        $('#cancelSite').show();
        $('#hasSiteBox').hide();
      }
      //移除场次信息条
      var hasSiteBox = document.getElementById('hasSiteBox');
      var oldDiv = document.getElementById('order' + id);
      hasSiteBox.removeChild(oldDiv);
      //移除订单信息条
      var orderform = document.getElementById('orderform');
      for(var i=1;i<=MAX_RESERVATION_NUM;i++){
        var willgameid = document.getElementById('game_id' + i);
        var willprice = document.getElementById('price' + i);
        var willstart_time = document.getElementById('start_time' + i);
        var willend_time = document.getElementById('end_time' + i);
        if (willgameid != null){
          if (willgameid.getAttribute("removeid") == id){
            orderform.removeChild(willgameid);
          }
        } 
        if (willprice != null){
          if (willprice.getAttribute("removeid") == id){
            orderform.removeChild(willprice);
          }
        } 
        if (willstart_time != null){
          if (willstart_time.getAttribute("removeid") == id){
            orderform.removeChild(willstart_time);
          }
        } 
        if (willend_time != null){
          if (willend_time.getAttribute("removeid") == id){
            orderform.removeChild(willend_time);
          }
        } 
      }
    }else{
      if (timesInput >= MAX_RESERVATION_NUM){
        alert("当前场次组合最多可选" + MAX_RESERVATION_NUM + "片场地！");
        return false;
      }else{
        element.setAttribute("class","checkSeat");//设为选中
        if (timesInput == 0){
          $('#cancelSite').hide();
          $('#hasSiteBox').show();
        }
        document.getElementById("timesInput").value = timesInput + 1;
        var idnum = timesInput + 1;
        for(var i=1;i<= MAX_RESERVATION_NUM;i++){
          var willadd = document.getElementById('game_id' + i);
          if (willadd == null){
            idnum = i;
            i = MAX_RESERVATION_NUM + 1;
          }
        } 
        document.getElementById("priceInput").value = priceInput + price;
        //生成场次信息条
        var title =  element.getAttribute("title");
        var hasSiteBox = document.getElementById('hasSiteBox');
        var newDiv = document.createElement('div');
        newDiv.setAttribute('class','isSite');
        newDiv.setAttribute('id','order' + id);
        newDiv.innerHTML = '<span>' + title + '</span>';
        hasSiteBox.appendChild(newDiv);
        //生成订单form信息
        var orderform = document.getElementById('orderform');
        var newGameIdInput = document.createElement('input');
        newGameIdInput.setAttribute('id','game_id' + idnum);
        newGameIdInput.setAttribute('name','reservations[][game_id]');
        newGameIdInput.setAttribute('value',game_id);
        newGameIdInput.setAttribute('type','hidden');
        newGameIdInput.setAttribute('removeid',id);
        orderform.appendChild(newGameIdInput);
        var newPriceInput = document.createElement('input');
        newPriceInput.setAttribute('id','price' + idnum);
        newPriceInput.setAttribute('name','reservations[][price]');
        newPriceInput.setAttribute('value',price);
        newPriceInput.setAttribute('type','hidden');
        newPriceInput.setAttribute('removeid',id);
        orderform.appendChild(newPriceInput);
        var newStartTimeInput = document.createElement('input');
        newStartTimeInput.setAttribute('id','start_time' + idnum);
        newStartTimeInput.setAttribute('name','reservations[][start_time]');
        newStartTimeInput.setAttribute('value',start_time);
        newStartTimeInput.setAttribute('type','hidden');
        newStartTimeInput.setAttribute('removeid',id);
        orderform.appendChild(newStartTimeInput);
        var newEndTimeInput = document.createElement('input');
        newEndTimeInput.setAttribute('id','end_time' + idnum);
        newEndTimeInput.setAttribute('name','reservations[][end_time]');
        newEndTimeInput.setAttribute('value',end_time);
        newEndTimeInput.setAttribute('type','hidden');
        newEndTimeInput.setAttribute('removeid',id);
        orderform.appendChild(newEndTimeInput);
      }
    }
    var fixtimes = document.getElementById("timesInput").value * 1;
    var fixprice = document.getElementById("priceInput").value * 1;
    if (fixtimes >= 1){
      var hasSiteInfo = document.getElementById("hasSiteInfo");
      hasSiteInfo.innerHTML ='已选择 <b class=\'m5 cf60\'>'+ fixtimes + '</b>个场地,共<b class=\'m5 cf60\'>' + fixprice + '元</b><p>再次单击取消</p>';
      $('#hasSiteInfo').show();
    }else{
      $('#hasSiteInfo').hide();
    }
  }
}
function validateform(){
  var timesInput =  document.getElementById("timesInput").value * 1;
  var r = false;
  if (timesInput <= 0){
    alert("你还没有选择场次，请选择左边的场次！");
  } else {
    r = true;
  }
  return r;
}
