class Prioritime.UsersSignOutRoute extends Ember.Route
  beforeModel: ->
    if Prioritime.CurrentUser
      Prioritime.FlashManager.setFlash("You have been signed out.", "warning")
      Prioritime.AuthManager.reset()
      @transitionTo("index")
    else
      Prioritime.FlashManager.setFlash("You aren't signed in.", "warning")
      @transitionTo('index')
