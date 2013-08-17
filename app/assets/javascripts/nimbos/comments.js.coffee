jQuery ->
  $(document).on "click", ".replytopost", (ev) ->
    ev.preventDefault()
    postElement = $(this)
    commentForm = "Post_" + postElement.data("post-id") + "_commentform"
    $.ajax
      url: "/nimbos/posts/" + postElement.data("post-id") + "/comments/new"
      type: "GET",
      dataType: "json",
      success: (data) ->
        document.getElementById(commentForm).innerHTML= JST["nimbos/templates/comments/form"](comment : data)