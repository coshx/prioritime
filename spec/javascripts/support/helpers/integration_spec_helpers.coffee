Ember.Test.registerHelper "jsonHeader", (app) ->
  { "Content-Type": 'application/json' }
  
Ember.Test.registerHelper "turnOnRESTAdapter", (app) ->
  Acac.ApplicationAdapter = DS.ActiveModelAdapter

Ember.Test.registerHelper  "mockAjaxRequests", (app) ->
  Acac.Server = sinon.fakeServer.create()

Ember.Test.registerHelper "selectFrom", (app, selector, value) ->
  find(selector).val(value)
  find(selector).change()
  equal(find(selector+" option:selected").val(), value)
  return wait()

Ember.Test.registerHelper "clearCurrentUser", (app) ->
  localStorage.removeItem("authentication_token")
  localStorage.removeItem("user_id")
  Acac.CurrentUser = null

Ember.Test.registerHelper "setCurrentUser", (app, roles) ->
  Acac.AuthManager ||= Acac.AuthenticationManager.create()
  user = build('logged_in_user', authentication_token: undefined)

  for roleAttr in roles
    role = build('role', roleAttr)
    user.get('roles').pushObject(role)

  Acac.CurrentUser = user
  Acac.AuthManager.set('currentUser', user)

Ember.Test.registerHelper "testAuthorizationRequiredRoute", (app, url) ->
  test 'Redirecting non-authorized users to root', ->
    setCurrentUser([])
    visit(url)

    andThen ->
      testEqual(currentRoute(), "index")
      testEqual(find(".alert:first").text(), "You are not authorized to access the page.")

Ember.Test.registerHelper "testAuthenticationRequiredRoute", (app, url) ->
  test 'Redirecting non-signed-in users to sign in page', ->
    visit(url)

    andThen ->
      testEqual(currentRoute(), "users.sign_in")
      testEqual(find(".alert:first").text(), "You need to sign in.")

Ember.Test.registerHelper "jsonFromRequestBody", (app, requestBody) ->
  decoded = decodeURIComponent(requestBody)  
  objects = decoded.split('&')

  modelKeys = []
  finalJSON = {}

  for object in objects
    # ex) ["user[email]", "user@email.com"]
    keyValueSplit = object.split('=', 2)
    
    key = keyValueSplit[0] # ex) "user[email]" 
    value = keyValueSplit[1] # ex) "user@email.com"

    model = key.substring(0, key.indexOf('[')) # ex) "user"
    field = key.substring(key.indexOf('[') + 1, key.indexOf(']')) # ex) "email"
    
    # initialize model's object if it's not there
    unless model in modelKeys
      modelKeys.push(model)
      finalJSON[model] = {}

    # add the field to the model object
    finalJSON[model][field] = value

  # ex) { user: { email: "user@email.com", password: "password"}}
  finalJSON