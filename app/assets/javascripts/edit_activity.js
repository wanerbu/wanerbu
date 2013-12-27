$(function() {
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
  });
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
