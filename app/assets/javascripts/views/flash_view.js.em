class Prioritime.FlashView extends Ember.View
  contentBinding: "flash"
  classNameBindings: ["alert", "alertClass"]
  alert: "alert"

  +computed content
  alertClass: ->
    'alert-' + @content.type