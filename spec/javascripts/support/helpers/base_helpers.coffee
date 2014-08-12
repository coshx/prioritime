Ember.Test.registerHelper "container", (app) ->
  Acac.__container__

Ember.Test.registerHelper "controller", (app, name) ->
  container().lookup "controller:" + name

Ember.Test.registerHelper "currentRoute", (app) ->
  controller("application").currentRouteName

Ember.Test.registerHelper "store", (app) ->
  container().lookup("store:main")
