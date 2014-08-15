class Prioritime.DashboardController extends Ember.Controller with Ember.Validations.Mixin
  actions:
    addWeeklyAssignment: ->
      controller = @
      weeklyAssignmentParams = { weekly_project_assignment: @newAssignment._attributes }

      $.post('/weekly_project_assignments', weeklyAssignmentParams, (response) ->
        controller.send('closeModal')

        console.log response

        target = Prioritime.DataStore.createRecord('weekly_project_assignment', response.weekly_project_assignment)
        target.week_start = moment(target.week_start).format('MM/DD/YYYY')
        projectAssignmentId = response.weekly_project_assignment.project_assignment_id


        projectAssignment = controller.calendarView.assignments[controller.personIndex].forEach (week) ->
          # console.log week.startDate
          # console.log target.week_start

          if week.startDate == target.week_start
            console.log 'found match!'
            # console.log project_assignment
            # console.log project_assignment.weekly_project_assignments
            week.weekly_assignments.push(target)

        controller.calendarView.setAssignmentsProxy()

        
        console.log target
        console.log controller.calendarView

      ).fail((response) ->
        flashMessage = response.responseJSON.weekly_project_assignments.join(", ")
        Prioritime.FlashManager.modalMode = true
        Prioritime.FlashManager.setFlash(flashMessage, 'danger')
      )
