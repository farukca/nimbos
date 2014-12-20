jQuery ->
  toggle_user_auth_form = ->
    if $("#user_authorized").is(":checked")
  	  $("#user_authorization_div").hide()
    else
  	  $("#user_authorization_div").show()

  $(document).on "click", "#user_authorized", (ev) ->
    toggle_user_auth_form()