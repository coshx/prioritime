class Prioritime.ModalPersonEditController extends Ember.ObjectController
  actions:
    submit: ->
      self = @
      person = this.get("model")
      onSuccess = (val) ->
        console.log("update successful")
        self.send("closeModal")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Updated team member", 'warning')
      onFailure = (message) ->
        console.log("error on update; message: " + message)
        self.send("closeModal")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Sorry, unable to update.", 'danger')
      person.save().then(onSuccess, onFailure)

    cancel: ->
      person = this.get("model")
      person.rollback()
      @send("closeModal")

