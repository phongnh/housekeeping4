handler = null
jQuery(document).ready ->
  handler = new HK.CheckboxHandler 'parent', 'child'
  jQuery('input#delete-button').click (e)->
    if !!handler.getChecked()
    else
      e.preventDefault()
      e.stopPropagation()
    return

  jQuery('input#transaction_date').datepicker { altField: "#transaction_date" }

  return

