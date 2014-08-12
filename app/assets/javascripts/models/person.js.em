# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.Person extends DS.Model
  name: DS.attr 'string'
  title: DS.attr 'string'
  description: DS.attr 'string'
  hourCapacity: DS.attr 'number'
  user: DS.belongsTo 'Prioritime.User'
