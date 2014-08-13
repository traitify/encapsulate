Router.addRoute('/result/:id', (id)->
  console.log(id);
)

Router.resource("birthday")
Router.addRoute('/', ->
  View.render("name", "/name")
)
Router.resource('name')
Router.resource('books')

App.initialize()