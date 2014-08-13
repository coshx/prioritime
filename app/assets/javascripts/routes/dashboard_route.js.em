stringToColor = (str) ->
  i = 0
  hash = 0

  while i < str.length
    hash = str.charCodeAt(i++) + ((hash << 5) - hash)
  color = Math.floor(Math.abs((Math.sin(hash) * 10000) % 1 * 16777216)).toString(16)
  "#" + Array(6 - color.length + 1).join("0") + color

class Prioritime.DashboardRoute extends Ember.Route
  model: ->
    @store.find('person')

  setupController: (controller, model) ->
    controller.set('people', model)
    controller.set('calendarHeight', model.length*100)

    # Get Monday of current week
    calendarStartDate = moment().startOf('week').add('days', 1)
    controller.set('calendarStartDate', calendarStartDate)

    weekStartDates = []

    for i in [0..6] by 1
      weekStartDates.push(calendarStartDate.add('days', 7).format('MM/DD'))

    controller.set('weekStartDates', weekStartDates)
