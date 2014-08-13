# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.ProjectAssignment extends DS.Model
  person: DS.belongsTo('Person')
  project: DS.belongsTo('Project')
  weekly_project_assignments: DS.hasMany('WeeklyProjectAssignments')
  summary: DS.attr('string')

  +computed project.name
  barColor: ->
    i = 0
    hash = 0

    while i < @project.name.length
      hash = @project.name.charCodeAt(i++) + ((hash << 5) - hash)

    color = Math.floor(Math.abs((Math.sin(hash) * 10000) % 1 * 16777216)).toString(16)
    "#" + Array(6 - color.length + 1).join("0") + color

      
