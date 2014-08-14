class Prioritime.DashboardController extends Ember.Controller

  actions:
    addWeeks: ->
      for i in [0..6] by 1
        @weekStartDates.push(@calendarStartDate.add('days', 7).format('MM/DD'))

      @set('weekStartDates', @weekStartDates)
