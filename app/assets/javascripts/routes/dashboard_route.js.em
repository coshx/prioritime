stringToColor = (str) ->

  # str to hash
  i = 0
  hash = 0

  while i < str.length
    hash = str.charCodeAt(i++) + ((hash << 5) - hash)

  # int/hash to hex
  i = 0
  colour = "#"

  while i < 3
    colour += ("00" + ((hash >> i++ * 8) & 0xFF).toString(16)).slice(-2)
  colour

class Prioritime.DashboardRoute extends Ember.Route
  setupController: (controller, model) ->
    controller.set('people', @store.find('person'))

    # Get Monday of current week
    calendarStart = moment().startOf('week').add('days', 1)
    weekStartDates = []

    for i in [0..8] by 1
      weekStartDates.push(calendarStart.add('days', i*7).format('MM/DD'))

    controller.set('weekStartDates', weekStartDates)

    ben_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, assignments: []})
      accum
    []
    )

    ben_week_projects[0].assignments.push(
      {days: 5, color: stringToColor("1"), id: 1}
    )

    chielo_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, assignments: []})
      accum
    []
    )

    dave_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, assignments: []})
      accum
    []
    )

    fakePeople = [
      {name: "Ben", week_projects: ben_week_projects },
      {name: "Chielo", week_projects: chielo_week_projects },
      {name: "Dave", week_projects: dave_week_projects  }
    ]

    controller.set('fakePeople', fakePeople)
