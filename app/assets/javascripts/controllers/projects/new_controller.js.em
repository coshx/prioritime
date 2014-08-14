class Prioritime.ProjectsNewController extends Ember.ObjectController with Ember.Validations.Mixin
  actions:
    submit: ->
      controller = @
      onSuccess = (val) ->
        console.log("successfully created new project")

        Ember.run.next ->
          controller.transitionToRoute("projects.index")
          Prioritime.FlashManager.setFlash("Added new team project!", 'warning')

      onFailure = (message) ->
        console.log("error in creating project")
        Prioritime.FlashManager.setFlash("Error in saving new team project", 'danger')

      @model.save().then(onSuccess, onFailure)


  validations:
    name:
      presence: true
