var handler;
handler = null;
jQuery(document).ready(function() {
  handler = new HK.CheckboxHandler('parent', 'child');
  jQuery('input#delete-button').click(function(e) {
    if (!!handler.getChecked()) {} else {
      e.preventDefault();
      e.stopPropagation();
    }
  });
  jQuery('input#transaction_date').datepicker({
    altField: "#transaction_date"
  });
});