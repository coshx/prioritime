class Prioritime.ApplicationRoute extends Ember.Route
  beforeModel: ->
    Prioritime.AuthManager ||= Prioritime.AuthenticationManager.create()
    Prioritime.AuthManager.authenticate()
    Prioritime.Calendar ||= Prioritime.CalendarManager.create()

  init: ->
    @._super()
    Prioritime.DataStore ||= Prioritime.__container__.lookup('store:main')
    Prioritime.FlashManager ||= Prioritime.FlashMessagesManager.create()

  actions:
    # clear flash before every route transition
    willTransition: (transition) ->
      if Prioritime.FlashManager.get('keep')
        Prioritime.FlashManager.set('keep', false)
      else
        Prioritime.FlashManager.clearFlash()

      @_super()

    error: (err) ->
      if err.status == 401
        Prioritime.FlashManager.setFlash(err.responseText, 'danger')

        if err.responseText == "You are not authorized to perform this action."
          @transitionTo('index')
        else
          @transitionTo('users.sign_in')

    openModal: (modalName, controllerName, model) ->
      if model?
        @controllerFor(controllerName).set('model', model)

      return @render('modals/' + modalName, {
        controller: controllerName
        into: 'application'
        outlet: 'modal'
      })

    closeModal: ->
      # $(".modal").modal('hide')
      Prioritime.FlashManager.modalMode = false
      Prioritime.FlashManager.clearFlash()

      return @disconnectOutlet({
        outlet: 'modal'
        parentView: 'application'
      })

