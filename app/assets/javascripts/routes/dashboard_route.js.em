Ember.Handlebars.registerBoundHelper 'find_project_for_date', (value, options) ->
  debugger

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
      accum.push({week: el, projects: []})
      accum
    []
    )

    ben_week_projects[0].projects.push({days: 5, id: 1})

    chielo_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, projects: []})
      accum
    []
    )

    dave_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, projects: []})
      accum
    []
    )

    fakePeople = [
      {name: "Ben", week_projects: ben_week_projects },
      {name: "Chielo", week_projects: chielo_week_projects },
      {name: "Dave", week_projects: dave_week_projects  }
    ]

    controller.set('fakePeople', fakePeople)
