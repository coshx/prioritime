class Prioritime.LoggedInUser extends DS.Model
  email: DS.attr('string')
  authentication_token: DS.attr('string')