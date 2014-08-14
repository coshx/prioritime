class Prioritime.PersonWeekView extends Ember.View
  occupiedDays: null
  freeDays: null
  hasFreeDays: null

  didInsertElement: ->
    view = @

    Ember.run ->
      view.setDays()

    # console.log @
    # @.$('.assignment-bar').on('mouseover', ->
    #   console.log 'over!'
    #   $(this).show()
    # )

    @.$('.assignment-bar.add').on('mouseover', ->
      $(this).text('Add')
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

    @week.forEach (assignment) ->
      view.occupiedDays += assignment.days_working

    @freeDays = 5 - @occupiedDays

    @determineFree()

  determineFree: ->
    if @freeDays > 0
      @hasFreeDays = true

  openAddModal: ->
    applicationRoute = Prioritime.__container__.lookup('route:application')
    currentRoute = Prioritime.__container__.lookup('controller:application').currentRouteName   

    Ember.run ->
      applicationRoute.send('openModal', 'add_weekly_assignment', currentRoute)