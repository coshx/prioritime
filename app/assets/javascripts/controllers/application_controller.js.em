class Prioritime.ApplicationController extends Ember.Controller
  +computed Prioritime.CurrentUser
  currentUser: ->
    Prioritime.CurrentUser

  +computed Prioritime.CurrentUser
  userSignedIn: ->
    if Prioritime.CurrentUser? then true else false

  +computed Prioritime.FlashManager.collection
  flashCollection: ->
    Prioritime.FlashManager.collection

  actions:
    logout: ->
      self = @
      Prioritime.AuthManager.reset()

      Ember.run.next ->
        self.transitionToRoute('users.sign_in')
