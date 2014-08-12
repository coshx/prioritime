Ember.Test.registerHelper "build", (app, className, options) ->
  store().makeFixture(className, options)

Ember.Test.registerHelper "buildList", (app, className, length, options) ->
  store().makeList(className, length, options)