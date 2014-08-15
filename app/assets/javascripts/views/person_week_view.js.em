class Prioritime.PersonWeekView extends Ember.View
  occupiedDays: null
  freeDays: null
  hasFreeDays: null

  didInsertElement: ->
    view = @

    Ember.run ->
      view.setDays()

    @.$('.assignment-bar.add').on('mouseover', ->
      $(this).text('Add')
    )

    @.$('.assignment-bar.overbooked').on('mouseover', ->
      $(this).color('red')
    )

    @.$('.assignment-bar.add').on('mouseout', ->
      $(this).text('')
    )

    @.$('.assignment-bar.add').on('click', ->
      view.openAddModal()
    )

  setDays: ->
    view = @
    @occupiedDays = 0

    @week.weekly_assignments.forEach (assignment) ->
      view.occupiedDays += assignment.days_working

    @freeDays = 5 - @occupiedDays

    @determineFree()

  determineFree: ->
    if @freeDays > 0
      @hasFreeDays = true

  openAddModal: ->
    view = @
    applicationRoute = Prioritime.__container__.lookup('route:application')
    currentRoute = Prioritime.__container__.lookup('controller:application').currentRouteName   
    projectAssignments = null
    newAssignment = null

    Ember.run ->
      view.controller.set('targetPerson', view.week.person)
      view.controller.set('targetStartDate', view.week.startDate)
      view.controller.set('maxDays', view.freeDays)

      Prioritime.DataStore.find('project_assignment', person_id: view.week.person.id).then((response) ->
        if response.content.length > 0
          view.controller.set('project_assignments', response)
          newAssignment = Prioritime.DataStore.createRecord('weekly_project_assignment', project_assignment_id: response.content[0].id or null, week_start: moment(view.week.startDate).format('YYYY-MM-DD'), days_working: view.freeDays)
          view.controller.set('newAssignment', newAssignment)
          view.controller.set('personIndex', view.personIndex)
          view.controller.set('calendarView', view.parentView)
          applicationRoute.send('openModal', 'add_weekly_assignment', currentRoute)
        # else
          # assign person to a project 
      )      