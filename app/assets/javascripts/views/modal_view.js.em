class Prioritime.ModalView extends Ember.View with Ember.ViewTargetActionSupport
  layoutName: 'modal'

  didInsertElement: ->
    $('.modal').modal()

  +computed Prioritime.FlashManager.collection
  flashCollection: ->
    Prioritime.FlashManager.collection

  +computed Prioritime.FlashManager.mode
  modalMode: ->
    Prioritime.FlashManager.mode == 'modal'