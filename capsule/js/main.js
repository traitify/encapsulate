Router = Object();
Router.addRoute = function(name, callBack){
  return Finch.route(name, callBack);
}
Router.resource = function(route){
  this.addRoute('/'+route, function() {
    View.render(route, route);
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

View.render = function(name, url){
  $.get("/api/"+url).done(function(data){
    View.cog(".main", $("[name='"+name+"']").html(), data);
  });
}

App = Object();
App.initialize = function(){
  Finch.listen();
}