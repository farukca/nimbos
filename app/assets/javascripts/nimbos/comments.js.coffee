jQuery ->
  $(document).on "click", ".replytopost", (ev) ->
    ev.preventDefault()
    postElement = $(this)
    commentForm = "Nimbos::Post_" + postElement.data("post-id") + "_commentform"
    $.ajax
      url: "/posts/" + postElement.data("post-id") + "/comments/new"
      type: "GET",
      dataType: "json",
      success: (data) ->
        document.getElementById(commentForm).innerHTML= JST["nimbos/templates/comments/form"](comment : data)