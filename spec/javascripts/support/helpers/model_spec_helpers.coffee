Ember.Test.registerHelper "hasRelationship", (app, model, relationship, association) ->
  target = Acac[model].metaForProperty(association)
  ok(target.isRelationship, 'Expecting isRelationship to be true, got false')
  equal(target.kind, relationship, 'Expected a hasMany relationship got: ' + target.kind)

Ember.Test.registerHelper "hasField", (app, model, attrName, attrType) ->
  testSubject = Acac[model].metaForProperty(attrName)
  equal(testSubject.type, attrType, 'Expected ' + attrType + ", got: " + testSubject.type)
  ok(testSubject.isAttribute)

Ember.Test.registerHelper "testComputedProperty", (app, model, record, computed_property, expected_output) ->
  Ember.run ->
    new_record = store().createRecord(model, record)
    computed = new_record.get(computed_property)
    testEqual(computed, expected_output)