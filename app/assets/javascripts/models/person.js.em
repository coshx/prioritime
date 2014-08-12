<<<<<<< HEAD
# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.Person extends DS.Model
  name: DS.attr 'string'
  title: DS.attr 'string'
  description: DS.attr 'string'
  hourCapacity: DS.attr 'number'
  user: DS.belongsTo 'Prioritime.User'
=======
class Prioritime.Person extends DS.Model
  name: DS.attr('string')
  title: DS.attr('string')
  description: DS.attr('string')
  hour_capacity: DS.attr('number')
  user_id: DS.attr('number')
>>>>>>> 6ab5159d5a25148737ebfed276e482bb8d512090
