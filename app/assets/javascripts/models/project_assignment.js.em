# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.ProjectAssignment extends DS.Model
  person: DS.belongsTo('Person')
  project: DS.belongsTo('Project')
  weekly_project_assignments: DS.hasMany('WeeklyProjectAssignments')
  summary: DS.attr('string')
