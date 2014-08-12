class Prioritime.DashboardRoute extends Ember.Route
  setupController: (controller, model) ->
    controller.set('people', @store.find('person'))

    # Get Monday of current week
    calendarStart = moment().startOf('week').add('days', 1)
    weekStartDates = []

    for i in [0..8] by 1
      console.log 'yay'
      weekStartDates.push(calendarStart.add('days', i*7).format('MM/DD'))

    controller.set('weekStartDates', weekStartDates)