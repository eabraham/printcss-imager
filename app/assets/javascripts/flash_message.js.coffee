$(document).ajaxComplete (event, xhr) ->
  debugger
  msg = xhr.responseText
  msg = xhr.getResponseHeader("X-Message")
  alert_type = 'alert-success'
  alert_type = 'alert-error' unless xhr.getResponseHeader("X-Message-Type").indexOf("error") is -1
 
  unless xhr.getResponseHeader("X-Message-Type").indexOf("keep") is 0
    if (msg)
      if (alert_type=='alert-success')
        alertify.success(msg)
      else
        alertify.error(msg)