class Prioritime.ApplicationRoute extends Ember.Route  
  beforeModel: ->
    Prioritime.AuthManager ||= Prioritime.AuthenticationManager.create() 
    Prioritime.AuthManager.authenticate()
    
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

    openModal: (modalName, controllerName) ->
      return @render('modals/' + modalName, {
        controller: controllerName
        into: 'application'
        outlet: 'modal'
      })

    closeModal: ->
      $(".modal").modal('hide')
      @disconnectModal

    disconnectModal: ->
      Prioritime.FlashManager.modalMode = false
      Prioritime.FlashManager.clearFlash()
      
      return @disconnectOutlet({
        outlet: 'modal'
        parentView: 'application'  
      })
