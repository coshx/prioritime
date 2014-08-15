class Prioritime.ModalProjectEditController extends Ember.ObjectController
  actions:
    submit: ->
      self = @
      project = @get("model")

      onSuccess = (val) ->
        console.log("update successful")
        self.send("closeModal")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Updated project", 'warning')

      onFailure = (message) ->
        console.log("error on update; message: " + message)
        self.send("closeModal")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Sorry, unable to update.", 'danger')

      date = @get("model").get("start_date")
      if date?
        parsed = Ember.Date.parse(date)
        @get("model").set("start_date", new Date(parsed))

      project.save().then(onSuccess, onFailure)

    cancel: ->
      project = @get("model")
      project.rollback()
      @send("closeModal")

