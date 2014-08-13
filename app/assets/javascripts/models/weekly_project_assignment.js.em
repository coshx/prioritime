# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.WeeklyProjectAssignment extends DS.Model
  week_start: DS.attr('date')
  days_working: DS.attr('number')

  +computed week_start
  position: (calendarStartDate) ->
    currentWeekNum = parseInt(moment().format("w"))
    startWeekNum = parseInt(moment(@week_start).format("w"))
    100*(startWeekNum - currentWeekNum)