Ember.Test.registerHelper "validates", (app, controller, field, type, expectedValue) ->
  if expectedValue is undefined
    equal(true, controller.get('validations')[field][type], 
      'Expected it to validate ' + type + " of " + field + ", but it didn't.")
  else
    actualValue = controller.get('validations')[field][type]

    if typeof expectedValue == 'object'
      wrongMatchFound = false

      $.each expectedValue, (key, val) ->
        unless actualValue[key] == val
          wrongMatchFound = true
          return

      testFalse(wrongMatchFound)
    else
      equal(expectedValue, controller.get('validations')[field][type],
        'Expected it to validate ' + type + " of " + field + ", but it didn't.")