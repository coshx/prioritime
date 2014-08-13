class Prioritime.UsersSignUpRoute extends Ember.Route
  model: ->
    @store.createRecord('user')