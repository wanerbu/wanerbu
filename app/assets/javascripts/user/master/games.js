//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
document.getElementById('price_rule_rule_type').onchange = function () {
  var date_style = this.value == '00' ? 'block' : 'none';
  var week_style = this.value == '01' ? 'block' : 'none';
  document.getElementById('select_date_price_rule').style.display = date_style;
  document.getElementById('select_week_price_rule').style.display = week_style;
};
