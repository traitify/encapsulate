Router.collection(".main", "books")
Router.collection(".main", "authors")



$.capsuleForm(".books")
$.capsuleForm(".authors")

$(->
  $.get("/pages/authentication", (data)->
    $("body").append(data)

    View.cog(".main", $("[name='authentication']").html(), Object())
  )
)

App.initialize()