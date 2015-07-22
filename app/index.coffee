express = require 'express'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

nconf = require './config'
log = require './logger'

app = express()
app.set 'views', "#{__dirname}/view"
app.set 'view engine', 'jade'

app.use cookieParser()
app.use bodyParser.json()

# app.use (req, res, next) ->
#   log.debug { req } ; next()

(require './front-end')(app)

if nconf.get 'admin'
  session = require 'express-session'
  users = require 'express-user-couchdb'

  log.info 'run admin'

  app.use session {
    secret: 'developers secret'
    resave: false
    saveUninitialized: false
  }

  app.use users {
    users: 'http://localhost:5984/_users'
    adminRoles: ['admin']
  }

if nconf.get 'static'
  app.use '/vendor', (express.static './bower_components')
  app.use '/', (express.static './www_public')

module.exports = app
