Ember.Handlebars.helper "date", (value, options) ->
  format = "M/D"
  format = options.hash.format  if options.hash.format
  if value
    time = moment(value).format(format)
    new Handlebars.SafeString(time)

Ember.Handlebars.helper "week_range", (value, options) ->
  format = "M/D"
  format = options.hash.format  if options.hash.format
  if value
    start = moment(value).format(format)
    end = moment(value).add('days', 4).format(format)
    new Handlebars.SafeString("#{start} - #{end}")
