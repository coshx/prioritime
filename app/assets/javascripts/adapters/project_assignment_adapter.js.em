class Prioritime.ProjectAssignmentAdapter extends DS.ActiveModelAdapter
  findQuery: (store, type, query) ->
    if query.person_id
      return this.ajax(
        '/project_assignments/for_person/' + query.person_id, 'GET', {}
      )