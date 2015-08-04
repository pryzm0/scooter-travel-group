nconf = require './config'
logger = require './logger'

express = require 'express'
app = express()

app.set 'views', "#{__dirname}/view"
app.set 'view engine', 'jade'

app.use (require 'body-parser').json()
app.use (require './route/index')

if nconf.get 'static:serve'
  logger.info '* serve static *'
  resolvePath = (require 'path').resolve
  for own path, dir of (nconf.get 'static:dir') \
      when dir = (resolvePath dir)
    logger.debug 'static', path, '->', dir
    app.use path, (express.static dir)

# export start()
module.exports = ->
  http = require 'http'

  host = nconf.get 'host'
  port = nconf.get 'port'

  http.createServer(app).listen port, host, ->
    logger.info "server started at #{host}:#{port}"
