#= require ../../spec_helper

module "Person model"

test "Data fields", ->
  hasField('Person', 'name', 'string')
  hasField('Person', 'title', 'string')
  hasField('Person', 'description', 'string')
  hasField('Person', 'hour_capacity', 'number')
  hasField('Person', 'user_id', 'number')