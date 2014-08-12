toPascalCase = (str) ->
  arr = str.split(/\s|_/)
  i = 0
  l = arr.length

  while i < l
    arr[i] = arr[i].substr(0, 1).toUpperCase() + ((if arr[i].length > 1 then arr[i].substr(1).toLowerCase() else ""))
    i++
  arr.join ""