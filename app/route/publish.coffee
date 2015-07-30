router = (require 'express').Router()
module.exports = router

nano = require 'nano'

nconf = require '../config'
logger = require '../logger'

router.use (req, res, next) ->
  unless req.session.user
    res.status(401).json { error: 'forbidden' }
  else
    req.db = nano({
      url: nconf.get 'database:url'
      cookie: req.session.nano.cookie
    })
    next()

router.get '/travel', (req, res) ->
  req.db.view 'articles', 'all', (err, body) ->
    if err then res.status(500).json(err)
    else res.json {
      total: body.rows.length
      rows: body.rows.map (row) ->
        id: row.key
        doc: {
          title: row.value.title
          author: row.value.author
        }
    }

router.post '/travel', (req, res) ->
  req.db.insert req.body, (err, body) ->
    if err then res.status(400).json(err)
    else req.db.get(body.id).pipe(res)

router.get '/travel/:key', (req, res) ->
  req.db.get(req.params.key).pipe(res)

router.post '/travel/:key', (req, res) ->
  if req.params.key != req.body._id
    return res.status(400).json { ok: false }
  req.db.insert req.body, (err, body) ->
    if err then res.status(400).json(err)
    else req.db.get(body.id).pipe(res)

router.delete '/travel/:key', (req, res) ->
  req.db.head req.params.key, (err, body, headers) ->
    etag = headers.etag.replace /['"]/g, ''
    if err then res.status(404).json(err)
    else req.db.destroy(req.params.key, etag).pipe(res)
