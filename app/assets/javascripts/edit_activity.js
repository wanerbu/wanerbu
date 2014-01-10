$(function() {
  $("#new_activity").validate({
    rules: {
      'activity[name]':"required",
      'activity[activity_type]':"required"
    },
  messages:{
    'activity[name]':"请输入活动名称",
    'activity[activity_type]':"请选择活动类型"
  }
  }); 
  //页面刷新时根据省ID取城市 
  var province_id = $('select#activity_province_id :selected').val();
  if(province_id == "") province_id ="0";

  jQuery.get('/activities/get_cities_by_province_id/' + province_id,
    function(data){
      $("#cities").html(data);
    });
  //选择某个省时根据省ID取城市
  $("#activity_province_id").change(function() {
    var province_id = $('select#activity_province_id :selected').val();
    if(province_id == "") province_id ="0";

    jQuery.get('/activities/get_cities_by_province_id/' + province_id,
      function(data){
        $("#cities").html(data);
      })
    return false;
  });  

  $('#new_activity input, #new_activity radio, #new_activity textarea, button').each(
      function(index){  
        var input = $(this);
        if (input.attr('type') != 'hidden'){
          input.focus(function(){
            var user_id =  document.getElementById("user_id").value;
            if (user_id == " "){
              $('#loginModal').modal('toggle');
            }
          });
        }
      });//检查是否登录

  $("input:radio").attr("checked", false);//类型选择初始化为什么都不选
  $("#activity_activity_address_input").removeClass("stringish");

  $('input:radio[name="activity[activity_type]"]').change(
      function(){
        if ($(this).is(':checked'))  {
          if ($(this).val() == 'sport'){
            $("#activity_activity_address").removeAttr("placeholder");
            $("#activity_activity_address").val("");
            $('#choseCourt').modal('toggle');
          }
          if ($(this).val() == 'other'){
            $("#activity_activity_address").removeAttr("readonly");
            $("#activity_province_id").attr("disabled",false);
            $("#activity_city_id").attr("disabled",false);
            $("#activity_area_id").attr("disabled",false);
            $("#activity_activity_address").attr("placeholder",'请输入地址');
          }
        }
      });//选择活动类型时相应地址处理

  $("#area").change(
      function(){
        jQuery.get('/activities/search/' + $(this).val() + "/gym",
          function(data){
            $('#gyms_select_div').show();    
            $("#gyms_select_div").html(data);
            $("#activity_court_id").val("");
          });
      }
      );//选择地区

  $('#choseCourt').on('hidden.bs.modal', function (e) {
    if ($("#activity_court_id").val() == ""){
      alert("请选场馆和择场地！");
      $('#choseCourt').modal('toggle');
    }else{
      $("#activity_province_id").val($("#gym_province_id").val()); 
      $("#activity_province_id").attr("disabled",true);
      $.ajax({
        url: '/activities/get_cities_by_province_id/' + $("#gym_province_id").val(),
        type: 'get',
        async: false,
        success:function(data){
          $("#cities").html(data);
          $("#activity_city_id").val($("#gym_city_id").val()); 
          $("#activity_city_id").attr("disabled",true);
        }
      });
      $.ajax({
        url: '/activities/get_areas_by_city_id/' + $("#gym_city_id").val(),
        type: 'get',
        async: false,
        success:function(data){
          $("#areas").html(data);
          $("#activity_area_id").val($("#gym_area_id").val()); 
          $("#activity_area_id").attr("disabled",true);
        }
      });
      $("#activity_activity_address").val($("#gym_address").val()); 
      $("#activity_activity_address").attr("readonly",'readonly');
    }
  });

  $("#submit_activity").click(function() {
    $('.datepair input.date').each(function(){
      var $this = $(this);
      if ($this.hasClass('start') || $this.hasClass('end')) {
        doSetDateParam($this);
      }
    });
    $('.datepair input.time').each(function() {
      var $this = $(this);
      if ($this.hasClass('start') || $this.hasClass('end')) {
        doSetTimeParam($this);
      }
    });
    $("#activity_area_id").attr("disabled",false);
    $("#activity_city_id").attr("disabled",false);
    $("#activity_province_id").attr("disabled",false);
  });//用户提交时将日期时间的值设到hidden里

  function doSetDateParam(target){
    targetField = target.attr("targetfield");
    targetVal = target.val();
    $("#"+targetField+"_1i").val(targetVal.substring(0,4)); 
    $("#"+targetField+"_2i").val(targetVal.substring(5,7)); 
    $("#"+targetField+"_3i").val(targetVal.substring(8,10)); 
  }
  function doSetTimeParam(target){
    targetField = target.attr("targetfield");
    targetVal = target.val();
    $("#"+targetField+"_4i").val(targetVal.substring(0,2)); 
    $("#"+targetField+"_5i").val(targetVal.substring(3,5)); 
  }
});
