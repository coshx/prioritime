class Prioritime.PersonSerializer extends DS.ActiveModelSerializer with DS.EmbeddedRecordsMixin
  attrs:
    project_assignments: { embedded: 'always' }