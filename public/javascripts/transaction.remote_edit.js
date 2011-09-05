var form, submitButton;
jQuery('#my_transaction_date').datepicker({
  altField: '#my_transaction_date'
});
submitButton = jQuery('#my_transaction_submit');
form = submitButton.parent();
form.submit(function(e) {
  e.preventDefault();
  e.stopPropagation();
  return false;
});
submitButton.click(function(e) {
  var params;
  e.preventDefault();
  e.stopPropagation();
  params = form.serialize();
  jQuery.ajax({
    type: "PUT",
    url: form.attr("action"),
    data: params,
    success: function(data) {
      if (data.status === "success") {
        window.location.reload();
      } else {
        jQuery('#fancybox-content > div').html(data);
      }
    },
    error: function(error) {}
  });
  return false;
});