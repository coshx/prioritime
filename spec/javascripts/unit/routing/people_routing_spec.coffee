#= ../../spec_helper

module 'People routing spec'

test 'people index route', ->
  routesTo("/people", "people.index")

test 'people new route', ->
  routesTo("/people/new", "people.new")

test 'people show route', ->
  routesTo("/people/sang", "people.show")

test 'people edit route', ->
  routesTo("/people/sang/edit", "people.edit")