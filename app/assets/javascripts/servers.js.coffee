servers = {}

window.server = (url) ->
  if typeof servers[url] == 'undefined'
    servers[url] = window.context.opentsdb(url)

  servers[url]
