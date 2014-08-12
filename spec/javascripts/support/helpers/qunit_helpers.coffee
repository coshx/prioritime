Ember.Test.registerHelper "testEqual", (app, actual, target) ->
  equal(actual, target, 
    "Expected: " + target + ", Got: " + actual
  )

Ember.Test.registerHelper "testDeepEqual", (app, actual, target) ->
  deepEqual(actual, target,
    "Expected: " + target + ", Got: " + actual
  )

Ember.Test.registerHelper "testTrue", (app, target) ->
  ok(target, "Expected " + target + " to be true")

Ember.Test.registerHelper "testFalse", (app, target) ->
  ok(!target, "Expected " + target + " to be false")

Ember.Test.registerHelper "testPresence", (app, target) ->
  ok(target, "Expected " + target + " to be present")

Ember.Test.registerHelper "testAbsence", (app, target) ->
  ok(!target, "Expected " + target + " to be absent")

