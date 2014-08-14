class Prioritime.ProjectAssignmentSerializer extends DS.ActiveModelSerializer with DS.EmbeddedRecordsMixin
  attrs:
    project: { embedded: 'always' }
    weekly_project_assignments: { embedded: 'always' }
    person_id: "person.id"
    project_id: "project.id"
