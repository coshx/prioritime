class Prioritime.PersonController extends Ember.ObjectController
  actions:
    delete: ->
      person = this.get("model")
      person.deleteRecord()
      onSuccess = (val) ->
        console.log("deletion successful")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Successfully removed team member", 'warning')
      onFailure = (message) ->
        console.log("error on delete; message: " + message)
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Sorry, unable to remove.", 'danger')
      person.save().then(onSuccess, onFailure)

