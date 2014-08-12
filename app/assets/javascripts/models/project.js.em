class Prioritime.Project extends DS.Model
  name: DS.attr('string')
  description: DS.attr('string')
  duration_weeks: DS.attr('number')
  start_date: DS.attr('date')
  client: DS.attr('string')