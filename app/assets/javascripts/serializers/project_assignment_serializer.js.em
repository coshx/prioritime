class Prioritime.ProjectAssignmentSerializer extends DS.ActiveModelSerializer with DS.EmbeddedRecordsMixin
  attrs:
    project: { embedded: 'always' }
    weekly_project_assignments: { embedded: 'always' }