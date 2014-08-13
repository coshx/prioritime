class Prioritime.UsersSignInController extends Ember.ObjectController with Ember.Validations.Mixin
  actions: 
    submit: ->
      controller = @

      userParams = { user: { email: @get('email'), password: @get('password') } }
      flashMessage = null

      $.post("/users/authenticate", userParams, (response) ->
        user = response.user
        Prioritime.AuthManager.setCurrentUser(user)
        Prioritime.AuthManager.setAjaxHeader(user.authentication_token, user.id)

        controller.transitionToRoute('index')
      ).fail((response) ->
        if response.status == 401
          Prioritime.FlashManager.setFlash(response.responseText, 'danger')
      )

  validations:
    email:
      presence: true

    password:
      presence: true