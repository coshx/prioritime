stringToColor = (str) ->
  i = 0
  hash = 0

  while i < str.length
    hash = str.charCodeAt(i++) + ((hash << 5) - hash)
  color = Math.floor(Math.abs((Math.sin(hash) * 10000) % 1 * 16777216)).toString(16)
  "#" + Array(6 - color.length + 1).join("0") + color

class Prioritime.DashboardRoute extends Ember.Route
  setupController: (controller, model) ->
    people = @store.find('person')
    controller.set('people', people)

    # Get Monday of current week
    calendarStartDate = moment().startOf('week').add('days', 1)
    controller.set('calendarStartDate', calendarStartDate)
    
    weekStartDates = []

    for i in [0..8] by 1
      weekStartDates.push(calendarStartDate.add('days', i*7).format('MM/DD'))

    controller.set('weekStartDates', weekStartDates)

    console.log people

    ben_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, assignments: []})
      accum
    []
    )

    ben_week_projects[0].assignments.push(
      {days: 5, color: stringToColor("1"), id: 1}
    )
    ben_week_projects[1].assignments.push(
      {days: 3, color: stringToColor("1"), id: 1}
    )
    ben_week_projects[1].assignments.push(
      {days: 2, color: stringToColor("2"), id: 2}
    )
    ben_week_projects[2].assignments.push(
      {days: 3, color: stringToColor("1"), id: 1}
    )
    ben_week_projects[2].assignments.push(
      {days: 2, color: stringToColor("2"), id: 2}
    )
    ben_week_projects[3].assignments.push(
      {days: 3, color: stringToColor("1"), id: 1}
    )
    ben_week_projects[3].assignments.push(
      {days: 2, color: stringToColor("2"), id: 2}
    )
    ben_week_projects[4].assignments.push(
      {days: 3, color: stringToColor("1"), id: 1}
    )
    ben_week_projects[4].assignments.push(
      {days: 2, color: stringToColor("2"), id: 2}
    )
    ben_week_projects[5].assignments.push(
      {days: 3, color: stringToColor("1"), id: 1}
    )
    ben_week_projects[5].assignments.push(
      {days: 2, color: stringToColor("2"), id: 2}
    )


    chielo_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, assignments: []})
      accum
    []
    )

    chielo_week_projects[0].assignments.push(
      {days: 5, color: stringToColor("1"), id: 1, week_num: 0}
    )
    chielo_week_projects[1].assignments.push(
      {days: 5, color: stringToColor("3"), id: 3, week_num: 100}
    )
    chielo_week_projects[2].assignments.push(
      {days: 5, color: stringToColor("3"), id: 3, week_num: 200}
    )
    chielo_week_projects[3].assignments.push(
      {days: 5, color: stringToColor("3"), id: 3, week_num: 300}
    )
    chielo_week_projects[4].assignments.push(
      {days: 5, color: stringToColor("3"), id: 3, week_num: 500}
    )

    dave_week_projects = weekStartDates.reduce( (accum, el) ->
      accum.push({week: el, assignments: []})
      accum
    []
    )

    dave_week_projects[0].assignments.push(
      {days: 4, color: stringToColor("5"), id: 5}
    )
    dave_week_projects[1].assignments.push(
      {days: 4, color: stringToColor("5"), id: 5}
    )
    dave_week_projects[2].assignments.push(
      {days: 4, color: stringToColor("5"), id: 5}
    )
    dave_week_projects[3].assignments.push(
      {days: 5, color: stringToColor("3"), id: 5}
    )
    dave_week_projects[4].assignments.push(
      {days: 5, color: stringToColor("3"), id: 5}
    )

    fakePeople = [
      # {name: "Ben", week_projects: ben_week_projects },
      {name: "Chielo", week_projects: chielo_week_projects }
      # {name: "Dave", week_projects: dave_week_projects  }
    ]

    controller.set('fakePeople', fakePeople)
