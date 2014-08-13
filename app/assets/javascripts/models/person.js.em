class Prioritime.Person extends DS.Model
  name: DS.attr('string')
  title: DS.attr('string')
  description: DS.attr('string')
  hour_capacity: DS.attr('number')
  user_id: DS.attr('number')
  project_assignments: DS.hasMany('project_assignment')