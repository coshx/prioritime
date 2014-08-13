class Prioritime.CalendarView extends Ember.View
  didInsertElement: ->
    # Add more weeks when it reaches horizontal end of the div
    @lastScrollLeft = 0
    view = @
    
    $("main#calendar").on("scroll", ->
      console.log $(this).scrollLeft()
    )