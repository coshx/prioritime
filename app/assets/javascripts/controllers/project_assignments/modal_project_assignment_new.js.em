class Prioritime.ModalProjectAssignmentNewController extends Ember.ObjectController
  +computed selected_person
  projects_for_person: ->
    person = @get("selected_person")
    return [] unless person?

    assignments = person.project_assignments
    assignedProjectIds = assignments.map (item) -> item.project.id
    projects = @get("model").projects
    validProjects = projects.reject (item, index, enumerable) ->
      assignedProjectIds.contains(item.id) # reject this item if the assigned project ids has this project's id in it - that means the person is already on the project

    validProjects

  actions:
    submit: ->
      self = @
      person = @get("selected_person")
      project = @get("selected_project")
      summary = @get("summary")
      project_assignment = @store.createRecord("project_assignment", {person: person, project: project, summary: summary})

      onSuccess = (val) ->
        console.log("assignment successful")
        self.set("selected_person", null)
        self.set("selected_project", null)
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
      @send("closeModal")

