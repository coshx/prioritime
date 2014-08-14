class Prioritime.ModalProjectAssignmentController extends Ember.Controller
  needs: ["application"]

  userSignedIn: -> Ember.computed.alias('controllers.application.userSignedIn')

  actions:
    "sign-in": ->
      @transitionToRoute("users.sign_in")
    "sign-up": ->
      @transitionToRoute("users.sign_up")
