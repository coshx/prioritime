# Teaspoon includes some support files, but you can use anything from your own support path too.
# require support/sinon
# require support/your-support-file
#
# PhantomJS (Teaspoons default driver) doesn't have support for Function.prototype.bind, which has caused confusion.
# Use this polyfill to avoid the confusion.
#= require support/bind-poly
#
# Deferring execution
# If you're using CommonJS, RequireJS or some other asynchronous library you can defer execution. Call
# Teaspoon.execute() after everything has been loaded. Simple example of a timeout:
#
# Teaspoon.defer = true
# setTimeout(Teaspoon.execute, 1000)
#
# Matching files
# By default Teaspoon will look for files that match _test.{js,js.coffee,.coffee}. Add a filename_test.js file in your
# test path and it'll be included in the default suite automatically. If you want to customize suites, check out the
# configuration in config/initializers/teaspoon.rb
#
# Manifest
# If you'd rather require your test files manually (to control order for instance) you can disable the suite matcher in
# the configuration and use this file as a manifest.
#
# For more information: http://github.com/modeset/teaspoon
#
# You can require your own javascript files here. By default this will include everything in application, however you
# may get better load performance if you require the specific files that are being used in the test that tests them.
#= require application
#= require ember_data_factory_guy
#= require_tree ./factories
#= require_tree ./support
#= require_self

# Define fixture adapters and use them
Prioritime.FixtureAdapter = DS.FixtureAdapter.extend(
  queryFixtures: (records, query, type) ->
    records.filter (record) ->
      for key of query
        continue  unless query.hasOwnProperty(key)
        value = query[key]
        return false if record[key] isnt value
      true
)

Prioritime.FixtureAdapterWithSlug = Prioritime.FixtureAdapter.extend(
  fixturesForType: (type) ->
    if type.FIXTURES
      fixtures = Ember.A(type.FIXTURES)
      return fixtures.map((fixture) ->

        fixture.id = fixture.slug
        fixtureIdType = typeof fixture.id
        throw new Error(fmt("the id property must be defined as a number or string for fixture %@", [fixture]))  if fixtureIdType isnt "number" and fixtureIdType isnt "string"
        fixture.id = fixture.id + ""
        fixture
      )
    null
)

Prioritime.ApplicationAdapter = Prioritime.FixtureAdapter
# Prioritime.FitnessClubAdapter = Prioritime.FixtureAdapterWithSlug
# Prioritime.CompanyAdapter = Prioritime.FixtureAdapterWithSlug

# Set up Ember test helpers
emq.globalize()
setResolver(Ember.DefaultResolver.create(namespace: Prioritime))

# Disable sinon fake timer
sinon.config.useFakeTimers = false

# Mock callbacks so that ajax promises would be resolved
Ember.Test.onInjectHelpers ->
  Ember.$(document).unbind "ajaxStart ajaxStop ajaxSend ajaxComplete"
  return

# Move app to an element on the page so it can be seen while testing.
document.write '<div id="ember-testing-container"><div id="ember-testing"></div></div>'
Prioritime.rootElement = "#ember-testing"
Prioritime.setupForTesting()
Prioritime.injectTestHelpers()

# Reset app before every test
QUnit.testStart = ->
  Prioritime.reset()
  # Prioritime.FlashManager.clearFlash() if Prioritime.FlashManager