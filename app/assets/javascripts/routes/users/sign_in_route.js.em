class Prioritime.UsersSignInRoute extends Ember.Route
  beforeModel: ->
    if Prioritime.CurrentUser 
      Prioritime.FlashManager.setFlash("You are already signed in.", "warning")
      @transitionTo('index')

  model: ->
    @store.createRecord('user')