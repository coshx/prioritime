#= ../../spec_helper

module 'Users routing spec'

test 'users sign_in route', ->
  routesTo("/users/sign_in", "users.sign_in")

test 'users sign_up route', ->
  routesTo("/users/sign_up", "users.sign_up")