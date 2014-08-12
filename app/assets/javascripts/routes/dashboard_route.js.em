class Prioritime.DashboardRoute extends Ember.Route
  model: (params, transition) ->
    @store.find('person')