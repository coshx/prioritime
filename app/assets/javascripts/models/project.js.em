# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.Project extends DS.Model
  name: DS.attr 'string'
  description: DS.attr 'string'
  durationWeeks: DS.attr 'number'
  startDate: DS.attr 'date'
  client: DS.attr 'string'
  user: DS.belongsTo 'Prioritime.User'
