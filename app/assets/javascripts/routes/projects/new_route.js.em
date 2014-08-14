class Prioritime.ProjectsNewRoute extends Ember.Route
  model: ->
    @store.createRecord("project")
