#= require ../../spec_helper

module "Root routing specs"

test "root route", ->
  routesTo("/", "index")