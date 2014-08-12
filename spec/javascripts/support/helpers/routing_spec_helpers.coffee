Ember.Test.registerHelper "routesTo", (app, url, routeName) ->
  routesChain = Prioritime.Router.router.recognizer.recognize(url)
  testEqual(routesChain[routesChain.length - 1].handler, routeName)