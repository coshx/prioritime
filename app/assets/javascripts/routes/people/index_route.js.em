class Prioritime.PeopleIndexRoute extends Ember.Route
  model: (params, transition) ->
    m = @store.find('person')
    m
