class Prioritime.DashboardRoute extends Ember.Route
  model: ->
    @store.find('person')

  fetchProjects: ->
    @store.find("project")

  setupController: (controller, model) ->
    controller.set('people', model)
    projects = @fetchProjects()
    controller.set('projects', projects)
    controller.set('people_projects', {people: model, projects: projects}) # for use by project assignment modal
    controller.set('calendarHeight', model.length*100)

    # Get Monday of current week
    calendarStartDate = moment().startOf('week').add('days', 1)
    console.log calendarStartDate

    Prioritime.Calendar.startDate = calendarStartDate
    Prioritime.Calendar.weekStartDates = [Prioritime.Calendar.startDate.format('MM/DD/YYYY')]

    for i in [0..6] by 1
      Prioritime.Calendar.weekStartDates.push(Prioritime.Calendar.startDate.add('days', 7).format('MM/DD/YYYY'))

    Prioritime.Calendar.setProxy()
