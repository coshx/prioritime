Ember.Handlebars.helper "bar-color", (value) ->
    i = 0
    hash = 0

    while i < value.length
      hash = value.charCodeAt(i++) + ((hash << 5) - hash)

    color = Math.floor(Math.abs((Math.sin(hash) * 10000) % 1 * 16777216)).toString(16)
    "#" + Array(6 - color.length + 1).join("0") + color

