class Prioritime.PeopleNewController extends Ember.ObjectController with Ember.Validations.Mixin
  actions:
    submit: ->
      controller = @
      onSuccess = (val) ->
        console.log("successfully created new person")

        Ember.run.next ->
          controller.transitionToRoute("people.index")
          Prioritime.FlashManager.setFlash("Added new team member!", 'warning')

      onFailure = (message) ->
        console.log("error in creating person")
        Prioritime.FlashManager.setFlash("Error in saving new team member", 'danger')

      @model.save().then(onSuccess, onFailure)


  validations:
    name:
      presence: true
