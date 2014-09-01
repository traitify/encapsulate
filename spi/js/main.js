Router = Object();
Router.addRoute = function(name, callBack){
  return Finch.route(name, callBack);
}
Router.collection = function(target, collection){
  this.addRoute("/"+collection, function() {
    View.render(target, collection, "collections/"+collection);
  });
}

var View  = Object();
View.cog = function(element, template, data){
  return new Ractive({
    el: element,
    template: template,
    data: data
  });
}

View.render = function(target, templateName, url){
  $.get("/api/"+url).done(function(data){
    dataEncapsulate = Object();
    dataEncapsulate[templateName] = data
    View.cog(target, $("[name='"+templateName+"']").html(), dataEncapsulate);
  });
}

$.capsuleForm = (function(selector){
  
  $(document).on("click", selector + " .form .submit", function(){
    submitData = Object();
    $form = $(this).parents(".form");
    key = $form.data("name");
    submitData[key] = Object();
    $form.find("input").each(function(i, input){
      submitData[key][$(this).data("name")] = $(this).val()
    })
    formName = selector.replace(".", "");
    $.post("/api/collections/" + formName, submitData, function(data){
      View.render(".main", formName, "/collections/"+ formName)
    })
  })

})


App = Object();

App.initialize = function(){
  Finch.listen();
}

currentUser = Object();
$.get("/me", function(data){
  App.currentUser = data;
  currentUser = data;
}, "json")

currentUser = function(callback){ 
  return App.currentUser;
}