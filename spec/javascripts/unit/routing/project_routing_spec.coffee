#= ../../spec_helper

module 'Projects routing spec'

test 'projects index route', ->
  routesTo("/projects", "projects.index")

test 'projects new route', ->
  routesTo("/projects/new", "projects.new")

test 'projects show route', ->
  routesTo("/projects/sang", "projects.show")

test 'projects edit route', ->
  routesTo("/projects/sang/edit", "projects.edit")