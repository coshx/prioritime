class Prioritime.FlashMessagesManager extends Ember.Object
  success: null
  info: null
  warning: null
  danger: null
  keep: false
  types: ['success', 'info', 'warning', 'danger']
  modalMode: false

  init: ->
    @_super()

  setFlash: (message, type, keep) ->
    flash = { message: message, type: type }
    @set(type, flash)
    @set('keep', keep) if keep

  clearFlash: ->
    for flashType in @types
      @set(flashType, null)

  +computed success, info, warning, danger
  collection: ->
    flashCollection = []

    for flashType in @types
      if flash = @get(flashType) then flashCollection.push(flash)

    return flashCollection



