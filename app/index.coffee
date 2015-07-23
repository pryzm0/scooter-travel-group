express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

app = express()

app.conf = nconf = require './config'
app.logger = require './logger'

app.set 'views', "#{__dirname}/view"
app.set 'view engine', 'jade'

app.use cookieParser()
app.use bodyParser.json()

if nconf.get 'logger:debugRequest'
  app.use (req, res, next) ->
    app.logger.debug { req } ; next()

(require './front-end')(app)

if nconf.get 'admin'
  app.logger.info 'run admin'

  session = require 'express-session'
  users = require 'express-user-couchdb'

  app.use session {
    secret: nconf.get 'session:secretKey'
    resave: false
    saveUninitialized: false
  }

  app.use users {
    users: nconf.get 'couch:users'
    adminRoles: ['admin']
  }

if nconf.get 'static:serve'
  app.logger.info 'serve static'
  for own path, dir of nconf.get 'static:dir'
    app.logger.debug 'static', path, '->', dir
    app.use path, (express.static ".#{dir}")

module.exports = app
