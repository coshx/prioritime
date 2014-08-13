class Prioritime.UsersSignUpController extends Ember.ObjectController with Ember.Validations.Mixin

  actions: 
    submit: ->
      controller = @
      userParams = { user: @get('model')._attributes }
      flashMessage = null

      $.post("/users", userParams, (response) ->
        user = response.user
        Prioritime.AuthManager.setCurrentUser(user)
        Prioritime.AuthManager.setAjaxHeader(user.authentication_token, user.id)

        controller.transitionToRoute('index')
      ).fail((response) ->
        if response.status == 401
          flashMessage = response.responseText
          Prioritime.FlashManager.setFlash(flashMessage, 'danger')
      )

  validations:
    email:
      presence: true

    password:
      presence: true
      confirmation: true
      length:
        minimum: 8