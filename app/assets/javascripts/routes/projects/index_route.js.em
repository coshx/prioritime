class Prioritime.ProjectsIndexRoute extends Ember.Route
  model: (params, transition) ->
    m = @store.find('project')
    m
