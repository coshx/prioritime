class Prioritime.ProjectController extends Ember.ObjectController
  actions:
    delete: ->
      project = this.get("model")
      project.deleteRecord()
      onSuccess = (val) ->
        console.log("deletion successful")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Successfully removed team project", 'warning')
      onFailure = (message) ->
        console.log("error on delete; message: " + message)
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Sorry, unable to remove.", 'danger')
      project.save().then(onSuccess, onFailure)

