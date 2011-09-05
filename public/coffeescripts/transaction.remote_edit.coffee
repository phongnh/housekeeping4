jQuery('#my_transaction_date').datepicker { altField: '#my_transaction_date' }

submitButton = jQuery('#my_transaction_submit')
form = submitButton.parent()

form.submit (e) ->
  e.preventDefault()
  e.stopPropagation()
  false

submitButton.click (e) ->
  e.preventDefault()
  e.stopPropagation()

  params = form.serialize()

  jQuery.ajax {
    type: "PUT"
    url: form.attr("action")
    data: params
    success: (data) ->
      if data.status is "success"
        window.location.reload()
      else
        jQuery('#fancybox-content > div').html data
      return

    error: (error) ->
      return
  }

  false

