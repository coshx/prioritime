#= require ../../spec_helper

module "ProjectAssignment model"

test "Data fields", ->
  hasField('ProjectAssignment', 'summary', 'string')
  hasField('ProjectAssignment', 'project_id', 'number')