# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.WeeklyProjectAssignment extends DS.Model
  week_start: DS.attr('date')
  days_working: DS.attr('number')
  project_assignment: DS.belongsTo('ProjectAssignment')
