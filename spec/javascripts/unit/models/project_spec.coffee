#= require ../../spec_helper

module "Project model"

test "Data fields", ->
  hasField('Project', 'name', 'string')
  hasField('Project', 'description', 'string')
  hasField('Project', 'client', 'string')
  hasField('Project', 'duration_weeks', 'number')
  hasField('Project', 'start_date', 'date')