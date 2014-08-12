class Prioritime.PeopleIndexRoute extends Ember.Route
  model: (params, transition) ->
    @store.find('person')