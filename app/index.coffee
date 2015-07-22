express = require 'express'
session = require 'express-session'
users = require 'express-user-couchdb'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

log = require './logger'

app = express()
app.set 'views', "#{__dirname}/view"
app.set 'view engine', 'jade'

# app.use (req, res, next) ->
#   log.debug { req } ; next()

app.use cookieParser()
app.use bodyParser.json()

app.use session {
  secret: 'developers secret'
  resave: false
  saveUninitialized: false
}

(require './front-end')(app)

app.use users {
  users: 'http://localhost:5984/_users'
  adminRoles: ['admin']
}

app.use '/vendor', (express.static './bower_components')
app.use '/', (express.static './www_public')

module.exports = app
