# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.ProjectAssignment extends DS.Model
  person: DS.belongsTo 'Prioritime.Person'
  project: DS.belongsTo 'Prioritime.Project'
  summary: DS.attr 'string'
