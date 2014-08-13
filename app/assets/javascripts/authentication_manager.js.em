class Prioritime.AuthenticationManager extends Ember.Object
  authentication: null
  currentUser: null

  # Load the current user if the cookies exist and is valid
  init: ->
    @_super()

  # Set current user and authentication
  setCurrentUser: (user) ->
    user = Prioritime.DataStore.createRecord('logged_in_user', user)
    Prioritime.CurrentUser = user
    @currentUser = user

  # Set up ajax header to be sent with every ajax request
  setAjaxHeader: (authenticationToken, userId) ->
    $.ajaxSetup(headers: { "X-User-Token": userId + ":" + authenticationToken })

  # Authenticate the user. Once they are authenticated, set the access token to be submitted with all
  # future AJAX requests to the server.
  authenticate: () ->
    authenticationToken = localStorage.getItem("authentication_token")
    userId = localStorage.getItem("user_id")
    self = this

    if authenticationToken != "null" and userId != "null"
      @setAjaxHeader(authenticationToken, userId)

      return $.get('/users/' + userId).then((response) ->
        self.setCurrentUser(response.user)
      ).fail((response) ->
        localStorage.setItem("user_id", null)
        localStorage.steItem("authentication_token", null)
      )

    return

  # Log out the user
  reset: ->    
    Ember.run.sync()
    self = @
    
    Ember.run.next ->
      currentUser = Prioritime.DataStore.getById('logged_in_user', Prioritime.CurrentUser.id)
      Prioritime.DataStore.unloadRecord(currentUser)
      Prioritime.CurrentUser = null
      
      self.set("currentUser", null)
      
      $.ajaxSetup(headers: { "X-User-Token": null })

      return

    return

  # Ensure that when the current user changes, we store the data in localStorage 
  # in order for us to load the user when the browser is refreshed
  +observer currentUser
  currentUserObserver: (->
    if @currentUser.authentication_token and @currentUser.id
      localStorage.setItem("authentication_token", @currentUser.authentication_token)
      localStorage.setItem("user_id", @currentUser.id)
    else
      localStorage.removeItem("authentiation_token")
      localStorage.removeItem("user_id") 
  )

# Reset the authentication if any ember data request returns a 401 unauthorized error
DS.rejectionHandler = (reason) ->
  App.AuthenticationManager.reset() if reason.status is 401
  throw reasonreturn