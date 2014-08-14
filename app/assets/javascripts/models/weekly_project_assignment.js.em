# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.WeeklyProjectAssignment extends DS.Model
  week_start: DS.attr('date')
  days_working: DS.attr('number')
  project_assignment: DS.belongsTo('ProjectAssignment')
  display: DS.attr('string')

  +computed week_start
  position: ->
    currentWeekNum = parseInt(moment().format("w"))
    startWeekNum = parseInt(moment(@week_start).format("w"))
    100*(startWeekNum - currentWeekNum)

  +computed week_start
  setDisplay: ->
    console.log 'calling here!'

    unless @display
      dates = Prioritime.Calendar.weekStartDates
      latestStartDate = dates[dates.length-2]

      if moment(@week_start).isAfter(moment(latestStartDate))
        @display = "none"
      else
        @display = "inline-block"

    ''