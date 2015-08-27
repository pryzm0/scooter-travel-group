router = (require 'express').Router()
module.exports = router

db = require '../database'
logger = require '../logger'
nconf = require '../config'

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
  db.view 'guide', 'link', (err, data) ->
    unless not err and (data.rows.length > 0) then res.status(404)
    else res.render 'guide-list', _t {
      guides: _.pluck(data.rows, 'value')
    }

router.get '/member/:name', (req, res) ->
  db.view 'guide', 'link', { key: req.params.name }, (err, data) ->
    unless not err and (data.rows.length > 0) then res.status(404)
    else res.render 'guide', _t {
      guide: _.first(data.rows).value
    }

router.get '/travel', (req, res) ->
  db.view 'article', 'link', (err, data) ->
    unless not err and (data.rows.length > 0) then res.status(404)
    else res.render 'route-list', _t {
      articles: _.pluck(data.rows, 'value')
    }

router.get '/travel/book', (req, res) ->
  res.render 'book', _t {}

router.get '/travel/next', (req, res) ->
  res.redirect '/travel/book'

router.get '/travel/:name', (req, res) ->
  db.view 'article', 'link', { key: req.params.name }, (err, data) ->
    unless not err and (data.rows.length > 0) then res.status(404)
    else res.render 'route', _t {
      article: _.first(data.rows).value
    }
