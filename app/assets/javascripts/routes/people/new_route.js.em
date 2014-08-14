class Prioritime.PeopleNewRoute extends Ember.Route
  model: ->
    @store.createRecord("person")
