class Prioritime.CalendarManager extends Ember.Object
  weekStartDates: null
  calendarStartDate: null
  weeklyStartDatesProxy: null

  init: ->
    @_super()

  setProxy: ->
    @weekStartDatesProxy = Ember.ArrayProxy.create(content: Ember.A(@weekStartDates))
