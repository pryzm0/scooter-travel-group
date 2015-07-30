express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
session = require 'express-session'

app = express()

app.conf = nconf = require './config'
app.logger = require './logger'

app.set 'views', "#{__dirname}/view"
app.set 'view engine', 'jade'

app.use cookieParser()
app.use bodyParser.json()
app.use session(nconf.get 'session')

(app.use (req, res, next) ->
  app.logger.debug { req }, req.path
  next()) if (nconf.get 'logger:debugRequest')

routes = nconf.get 'routes'
Object.keys(routes).forEach (path) ->
  route = require "./#{routes[path]}"
  app.use path, route

if nconf.get 'admin'
  app.logger.info '* run admin *'

  # Grant = require 'grant-express'
  couchUser = require 'express-user-couchdb'

  # app.use (new Grant(nconf.get 'grant'))
  app.use couchUser(nconf.get 'couch')

if nconf.get 'static:serve'
  app.logger.info '* serve static *'
  resolvePath = (require 'path').resolve
  for own path, dir of nconf.get 'static:dir' when (dir = resolvePath dir)
    app.logger.debug 'static', path, '->', dir
    app.use path, (express.static dir)

module.exports = app
