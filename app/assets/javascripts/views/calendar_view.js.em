class Prioritime.CalendarView extends Ember.View
  personWeeksAssignments: []
  assignments: []

  didInsertElement: ->
    # Add more weeks when it reaches horizontal end of the div
    view = @

    $("main#calendar").scroll(->
      if $(this).scrollLeft() + $(this).innerWidth() >= $(this)[0].scrollWidth
        view.addWeeks()
    )

    @setPersonWeeksAssignments()

  # NOTE ember doesn't have groupBy on enumberable yet :/
  # I am basically grouping by date in weekStartDates here but making
  # sure that every date gets at least an empty array
  setPersonWeeksAssignments: ->
    @assignments = @people.map (person) =>
      @weekStartDates.reduce( (accum, startDate) ->
        weekly_project_assignments = []

        person.project_assignments.forEach (project_assignment) ->
          project_assignment.weekly_project_assignments.forEach (weekly) ->

            if moment(weekly.week_start).day(1).format('MM/DD/YYYY') == startDate
              weekly_project_assignments.push(weekly)

        person_week = { person: person, startDate: startDate, weekly_assignments: weekly_project_assignments }

        accum.push(person_week)
        accum
      []
      ) 

    @setAssignmentsProxy()
   

  setAssignmentsProxy: (assignments) ->
    console.log 'setting!'
    @personWeeksAssignments = Ember.ArrayProxy.create(content: Ember.A(@assignments))
  
  addWeeks: ->
    for i in [0..6] by 1
      Prioritime.Calendar.weekStartDates.push(Prioritime.Calendar.startDate.add('days', 7).format('MM/DD/YYYY'))
    
    Prioritime.Calendar.setProxy()

    @set('weekStartDates', Prioritime.Calendar.weekStartDates)
    @setPersonWeeksAssignments()