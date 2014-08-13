class Prioritime.IndexController extends Ember.Controller
  actions:
    "sign-in": ->
      @transitionToRoute("users.sign_in")
    "sign-up": ->
      @transitionToRoute("users.sign_up")
