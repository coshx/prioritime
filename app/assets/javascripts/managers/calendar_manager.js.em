class Prioritime.CalendarManager extends Ember.Object
  weekStartDates: null
  calendarStartDate: null
  weeklyStartDatesProxy: null

  init: ->
    @_super()

  setProxy: ->
    @weekStartDatesProxy = Ember.ArrayProxy.create(content: Ember.A(@weekStartDates))

  addWeeks: ->
    previousLatestDate = @startDate.format('MM/DD/YYYY')

    for i in [0..6] by 1
      Prioritime.Calendar.weekStartDates.push(@startDate.add('days', 7).format('MM/DD/YYYY'))
      @setProxy()

    currentLatestDate = @startDate.format('MM/DD/YYYY')

    assignmentsToDisplay = Prioritime.DataStore.filter('weekly_project_assignment', (assignment) ->
      weekStart = moment(assignment.week_start)
      if weekStart.isAfter(moment(previousLatestDate)) and weekStart.isBefore(moment(currentLatestDate))
        true
    ).then((assignmentsToDisplay) ->
      console.log assignmentsToDisplay

      for assignment in assignmentsToDisplay.content
        console.log 'changed display!'
        assignment.set('display', 'inline-block')
    )

