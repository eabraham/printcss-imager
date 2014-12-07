$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Message")
  alert_type = 'alert-success'
  alert_type = 'alert-error' unless request.getResponseHeader("X-Message-Type").indexOf("error") is -1
 
  unless request.getResponseHeader("X-Message-Type").indexOf("keep") is 0
    if (msg)
      if (alert_type=='alert-success')
        alertify.success(msg)
      else
        alertify.error(msg)