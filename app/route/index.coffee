router = (require 'express').Router()
module.exports = router

nconf = require '../config'
logger = require '../logger'

db = (require 'nano')(nconf.get 'database')
Remarkable = require 'remarkable'

_ = require 'lodash'
_t = (scope) -> _.extend scope, {
  _conf: nconf
  _markdown: (template) ->
    new Remarkable().render template
}


router.get '/', (req, res) ->
  res.render 'index', _t {}

router.get '/community', (req, res) ->
  res.render 'guide-list', _t {}

router.get '/member/:name', (req, res) ->
  res.render 'guide', _t {}

router.get '/travel', (req, res) ->
  db.view 'articles', 'link', (err, data) ->
    unless not err and (data.rows.length > 0) then res.status(404)
    else res.render 'route-list', _t {
      articles: _.pluck(data.rows, 'value')
    }

router.get '/travel/book', (req, res) ->
  res.render 'book', _t {}

router.get '/travel/next', (req, res) ->
  res.redirect '/travel/book'

router.get '/travel/:name', (req, res) ->
  db.view 'articles', 'link', { key: req.params.name }, (err, data) ->
    unless not err and (data.rows.length > 0) then res.status(404)
    else res.render 'route', _t {
      article: _.first(data.rows).value
    }
