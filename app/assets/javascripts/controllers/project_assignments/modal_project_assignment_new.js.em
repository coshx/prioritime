class Prioritime.ModalProjectAssignmentNewController extends Ember.ObjectController
  actions:
    submit: ->
      self = @
      person = this.get("person")
      project = this.get("project")
      summary = this.get("summary")
      project_assignment = @store.createRecord("project_assignment", {person: person, project: project, summary: summary})
      # project_assignment.set("person_id", person.id)
      # project_assignment.set("project_id", project.id)
      # project_assignment.set("summary", summary)
      # console.log(project_assignment)

      onSuccess = (val) ->
        console.log("assignment successful")
        self.send("closeModal")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Assigned team member to project", 'warning')
      onFailure = (message) ->
        console.log("error on trying to assign to project; message: " + message)
        self.send("closeModal")
        Ember.run.next ->
          Prioritime.FlashManager.setFlash("Sorry, unable to assign that person to the project.", 'danger')
      project_assignment.save().then(onSuccess, onFailure)

    cancel: ->
#      person = this.get("model")
#      person.rollback()
      @send("closeModal")

