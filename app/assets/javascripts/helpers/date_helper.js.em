Ember.Handlebars.helper "date", (value, options) ->
  format = "MM/DD"
  format = options.hash.format  if options.hash.format
  if value
    time = moment(value).format(format)
    new Handlebars.SafeString(time)