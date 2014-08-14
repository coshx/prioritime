class Prioritime.CalendarView extends Ember.View
  didInsertElement: ->
    # Add more weeks when it reaches horizontal end of the div
    @lastScrollLeft = 0
    view = @

    $("main#calendar").on("scroll", ->
      console.log $(this).scrollLeft()
    )

  +computed people weekStartDates
  # NOTE ember doesn't have groupBy on enumberable yet :/
  # I am basically grouping by date in weekStartDates here but making
  # sure that every date gets at least an empty array
  person_weeks_assignments: ->
    @people.map (person) =>
      @weekStartDates.reduce( (accum, startDate) ->
        weekly_project_assignments = []
        person.project_assignments.forEach (project_assignment) ->
          project_assignment.weekly_project_assignments.forEach (weekly) ->
            if moment(weekly.week_start).day(1).format('MM/DD') == startDate
              weekly_project_assignments.push(weekly)
        accum.push(weekly_project_assignments)
        accum
      []
      )
