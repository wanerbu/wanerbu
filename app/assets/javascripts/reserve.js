//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
var MAX_RESERVATION_NUM = 4;
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
      remove_order_input(id);
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
    show_fix_times_price();
  }
}
function show_fix_times_price(){
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
var r = false;
function validateform(){
  var timesInput =  document.getElementById("timesInput").value * 1;
  if (timesInput <= 0){
    alert("你还没有选择场次，请选择左边的场次！");
  } else {
    if(!$("#telephone_no").val().match(/^1[3|4|5|8][0-9]\d{4,8}$/)){
      alert("手机号码格式不正确！请重新输入！"); 
    }else{
      $.ajax({
        url: '/gym/check_order',
        type: 'post',
        dataType: 'json',
        async: false,
        data: $('form#orderform').serialize(),
        success:function(data) {
          if (jQuery.isEmptyObject(data)){//所选场次没有被占
            r = true;
          }else{
            var checkedHas = document.getElementById('checkedHas');
            var arrID = new Array();
            $.each(data, function (index, value) {
              id = value["game_id"]+value["start_time"].substring(0,4) + value["start_time"].substring(5,7) + value["start_time"].substring(8,10) + value["start_time"].substring(11,13) + value["start_time"].substring(14,16);
              arrID.push(id);
              //生成Modal上的场次信息条
              var element = document.getElementById(id);
              var title =  element.getAttribute("title");
              var newDiv = document.createElement('div');
              newDiv.setAttribute('class','isSite');
              newDiv.innerHTML = '<span>' + title + '</span>';
              checkedHas.appendChild(newDiv);
            });
            $('#checkorderModal').modal('toggle');
            $('#checkorderModal').on('hidden.bs.modal', function (e) {
              var hasSiteBox = document.getElementById('hasSiteBox');
              var orderform = document.getElementById('orderform');
              for(i=0;i<arrID.length;i++){
                var timesInput = document.getElementById("timesInput").value * 1;
                var priceInput = document.getElementById("priceInput").value * 1;
                //移除主页面的场次信息条
                oldDiv = document.getElementById('order' + arrID[i]);
                hasSiteBox.removeChild(oldDiv);
                //设为已售出
                select_element = document.getElementById(arrID[i]);
                select_element.setAttribute("class","sellSeat");
                //移除选主页面的择方法
                select_element.removeAttribute("onclick");
                select_element.innerHTML = "";
                var price = select_element.getAttribute("price") * 1;
                document.getElementById("timesInput").value = timesInput - 1;
                document.getElementById("priceInput").value = priceInput - price;
                //移除订主页面的单信息
                remove_order_input(arrID[i]);
              } 
              show_fix_times_price();
              checkedHas.innerHTML = "";
            });
            r = false;
          }
        }
      });
    }
  }
  return r;
}
function remove_order_input(id){
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
}
function select_p(id,game_id){
  var select_num = document.getElementById("select"+id).value * 1;
  var user_id =  document.getElementById("user_id").value;
  if (user_id == " " && select_num > 0){
    $('#loginModal').modal('toggle');
  }else{
    var element = document.getElementById(id);
    var start_time = element.getAttribute("start_time");
    var end_time = element.getAttribute("end_time");
    var price =  element.getAttribute("price") * 1;
    var peoplesInput =  document.getElementById("peoplesInput").value * 1;
    var pre_num = document.getElementById("pre"+id).value  * 1;
    var user_id =  document.getElementById("user_id").value;
    peoplesInput = peoplesInput + select_num - pre_num;
    if (peoplesInput > 0){
      $('#cancelSite').hide();
      $('#hasSiteBox').show();
    } 
    if (peoplesInput == 0 ){
      $('#cancelSite').show();
      $('#hasSiteBox').hide();
    }
    var hasSiteBox = document.getElementById('hasSiteBox');
    var orderform = document.getElementById('orderform');
    if ( select_num > 0){
      var lang =  element.getAttribute("lang");
      if (pre_num == 0){
        var newDiv = document.createElement('div');
        newDiv.setAttribute('class','isSite');
        newDiv.setAttribute('id','order' + id);
        newDiv.setAttribute('fortotalprice','order' + id);
        newDiv.setAttribute('price',price * select_num);
        newDiv.innerHTML = '<span>' + lang +" "+select_num + "人 共"+ price * select_num +'元</span>';
        hasSiteBox.appendChild(newDiv);
        //生成订单form信息
        var newGameIdInput = document.createElement('input');
        newGameIdInput.setAttribute('id','game_id' + id);
        newGameIdInput.setAttribute('name','reservations[][game_id]');
        newGameIdInput.setAttribute('value',game_id);
        newGameIdInput.setAttribute('type','hidden');
        orderform.appendChild(newGameIdInput);
        var newPriceInput = document.createElement('input');
        newPriceInput.setAttribute('id','price' + id);
        newPriceInput.setAttribute('name','reservations[][price]');
        newPriceInput.setAttribute('value',price);
        newPriceInput.setAttribute('type','hidden');
        orderform.appendChild(newPriceInput);
        var newStartTimeInput = document.createElement('input');
        newStartTimeInput.setAttribute('id','start_time' + id);
        newStartTimeInput.setAttribute('name','reservations[][start_time]');
        newStartTimeInput.setAttribute('value',start_time);
        newStartTimeInput.setAttribute('type','hidden');
        orderform.appendChild(newStartTimeInput);
        var newEndTimeInput = document.createElement('input');
        newEndTimeInput.setAttribute('id','end_time' + id);
        newEndTimeInput.setAttribute('name','reservations[][end_time]');
        newEndTimeInput.setAttribute('value',end_time);
        newEndTimeInput.setAttribute('type','hidden');
        orderform.appendChild(newEndTimeInput);
        var newPeopleNumInput = document.createElement('input');
        newPeopleNumInput.setAttribute('id','people_num' + id);
        newPeopleNumInput.setAttribute('name','reservations[][people_num]');
        newPeopleNumInput.setAttribute('value',select_num);
        newPeopleNumInput.setAttribute('type','hidden');
        orderform.appendChild(newPeopleNumInput);
      }else{
        oldDiv =  document.getElementById('order'+id);
        oldDiv.setAttribute('price',price * select_num);
        oldDiv.innerHTML = '<span>' + lang +" "+select_num + "人 共"+ price * select_num +'元</span>';
        oldPeopleNumInput =  document.getElementById('people_num'+id);
        oldPeopleNumInput.setAttribute('value',select_num);
      }
    }else if (pre_num > 0){
      oldDiv =  document.getElementById('order'+id);
      hasSiteBox.removeChild(oldDiv);
      oldGameIdInput =  document.getElementById('game_id'+id);
      orderform.removeChild(oldGameIdInput);
      oldPriceInput =  document.getElementById('price'+id);
      orderform.removeChild(oldPriceInput);
      oldStartTimeInput =  document.getElementById('start_time'+id);
      orderform.removeChild(oldStartTimeInput);
      oldEndTimeInput =  document.getElementById('end_time'+id);
      orderform.removeChild(oldEndTimeInput);
      oldPeopleNumInput =  document.getElementById('people_num'+id);
      orderform.removeChild(oldPeopleNumInput);
    }
    document.getElementById("peoplesInput").value = peoplesInput;
    document.getElementById("pre"+id).value = select_num;
    //计算总价
    var totalprice = 0 ;
    $("div[fortotalprice^='order']").each(
        function(i){
          totalprice = totalprice + this.getAttribute("price") * 1;
        }
        );
    if (peoplesInput >= 1){
      var hasSiteInfo = document.getElementById("hasSiteInfo");
      hasSiteInfo.innerHTML ='共<b class=\'m5 cf60\'>' + totalprice + '元</b>';
      $('#hasSiteInfo').show();
    }else{
      $('#hasSiteInfo').hide();
    }
  }
}
function validateform_p(){
  r = false;
  var peoplesInput =  document.getElementById("peoplesInput").value * 1;
  if ( peoplesInput <= 0){
    alert("你还没有选择场次，请选择左边的场次！");
  } else {
    if(!$("#telephone_no").val().match(/^1[3|4|5|8][0-9]\d{4,8}$/)){
      alert("手机号码格式不正确！请重新输入！"); 
    }else{
      $.ajax({
        url: '/gym/check_order',
        type: 'post',
        dataType: 'json',
        async: false,
        data: $('form#orderform').serialize(),
        success:function(data) {
          if (jQuery.isEmptyObject(data)){//所选场次没有被占
            r = true;
          }else{
            var checkedHas = document.getElementById('checkedHas');
            $.each(data, function (index, value) {
              id = value["game_id"]+value["start_time"].substring(0,4) + value["start_time"].substring(5,7) + value["start_time"].substring(8,10);
              //生成Modal上的场次信息条
              var element = document.getElementById("order"+id);
              var newDiv = document.createElement('div');
              newDiv.setAttribute('class','isSite');
              newDiv.innerHTML = element.innerHTML; 
              checkedHas.appendChild(newDiv);
            });
            $('#checkorderModal').modal('toggle');
            $('#checkorderModal').on('hidden.bs.modal', function (e) {
              var hasSiteBox = document.getElementById('hasSiteBox');
              var orderform = document.getElementById('orderform');
              $.each(data, function (index, value) {
                id = value["game_id"]+value["start_time"].substring(0,4) + value["start_time"].substring(5,7) + value["start_time"].substring(8,10);
                people_num = value["people_num"] * 1;
                if (people_num > 0){
                  //更改select的option
                  $("#select"+id + " option").each(function(){
                    if ($(this).val() * 1 > people_num){
                      $(this).remove();
                    }
                  });
                  //把最大值设为以已选
                  last_option = $("#select"+id +" option:last");
                  last_option.prop('selected',true); 
                  //更改提示人数信息
                  remainDiv = document.getElementById("remain"+id);
                  remainDiv.innerHTML =  "<em>剩余" + people_num +"人</em>";
                  //调用select_p方法
                  select_p(id,value["game_id"]);
                }else{
                  select = $('#select'+id);
                  //把0设为以已选
                  select.val("0");
                  //调用select_p方法
                  select_p(id,value["game_id"]);
                  //删除select控件
                  select.remove();
                  //更改选项样式
                  var box = document.getElementById(id);
                  box.setAttribute("class","");//取消选中
                  //更改提示人数信息
                  remainDiv = document.getElementById("remain"+id);
                  remainDiv.innerHTML =  " <em>名额已满,暂不能预订</em>";
                  infoDiv = document.getElementById("info"+id);
                  infoDiv.innerHTML =  "";
                }
              });
              checkedHas.innerHTML = "";
            });
          }
        }
      });
    }
  }
  return r;
}
