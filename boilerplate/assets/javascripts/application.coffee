Router.collection(".main", "books")
Router.collection(".main", "authors")



$.capsuleForm(".books")
$.capsuleForm(".authors")

$(->
  View.cog(".main", $("[name='authentication']").html(), Object())
)

App.initialize()