jQuery ->
  $(document).on "click", ".edit_task input[type=checkbox]", (ev) ->
    ev.preventDefault()
    $(this).parents('form').submit()