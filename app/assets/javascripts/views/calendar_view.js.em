class Prioritime.CalendarView extends Ember.View
  didInsertElement: ->
    # Add more weeks when it reaches horizontal end of the div
    @lastScrollLeft = 0
    view = @

    $("main#calendar").on("scroll", ->
      console.log $(this).scrollLeft()
    )

  +computed people weekStartDates
  person_weeks_assignments: ->
    @people.map (person) =>
      @weekStartDates.reduce( (accum, el) ->
        project_assignments = person.project_assignments
        console.log(person)
        accum.startDate = el
        debugger
        accum
      {}
      )
