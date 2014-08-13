#=require ../../spec_helper

module "User Model",

test 'Data fields', ->
  hasField("User", "email", "string")
  hasField("User", "password", "string")