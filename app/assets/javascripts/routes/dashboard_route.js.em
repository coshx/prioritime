class Prioritime.DashboardRoute extends Ember.Route
  model: ->
    @store.find('person')

  setupController: (controller, model) ->
    controller.set('people', model)
    controller.set('calendarHeight', model.length*100)

    # Get Monday of current week
    calendarStartDate = moment().startOf('week').add('days', 1)

    Prioritime.Calendar.startDate = calendarStartDate
    Prioritime.Calendar.weekStartDates = []

    for i in [0..6] by 1
      Prioritime.Calendar.weekStartDates.push(Prioritime.Calendar.startDate.add('days', 7).format('MM/DD/YYYY'))

    Prioritime.Calendar.setProxy()