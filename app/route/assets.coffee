_ = require 'lodash'
Q = require 'q'

router = (require 'express').Router()
module.exports = router

db = require '../database'
logger = require '../logger'
nconf = require '../config'

execStream = require 'exec-stream'
convert = (profile) -> execStream('convert',
  (switch profile
    when 'thumbnail'
      ['-', '-strip', '-resize', 'x50', '-quality', '70', 'jpeg:-']
    else
      ['-', '-strip', '-resize', 'x350', '-quality', '76', 'jpeg:-']))

viewLink = (ddoc, key) -> Q.Promise (resolve) ->
  db.view ddoc, 'link', { key }, (err, data) ->
    unless not err and (data.rows.length > 0)
      throw new Error("not found: #{key}")
    resolve _.first(data.rows)

expireTime = nconf.get 'cache:expire'
router.use (req, res, next) ->
  expires = new Date(Date.now() + expireTime*1000)
  res.set 'Cache-Control', "public, max-age=#{expireTime}"
  res.set 'Expires', expires.toUTCString()
  next()

router.get '/image/travel/:name/:file', (req, res) ->
  viewLink('article', req.params.name)
    .then (doc) ->
      db.attachment.get(doc.id, req.params.file)
        .pipe(convert('default'))
        .pipe(res)
    .fail ->
      res.status(404)

router.get '/image/travel/:name/thumb/:file', (req, res) ->
  viewLink('article', req.params.name)
    .then (doc) ->
      db.attachment.get(doc.id, req.params.file)
        .pipe(convert('thumbnail'))
        .pipe(res)
    .fail ->
      res.status(404)

router.get '/image/guide/:name/:file', (req, res) ->
  viewLink('guide', req.params.name)
    .then (doc) ->
      db.attachment.get(doc.id, req.params.file)
        .pipe(convert('default'))
        .pipe(res)
    .fail ->
      res.status(404)

router.get '/image/guide/:name/thumb/:file', (req, res) ->
  viewLink('guide', req.params.name)
    .then (doc) ->
      db.attachment.get(doc.id, req.params.file)
        .pipe(convert('thumbnail'))
        .pipe(res)
    .fail ->
      res.status(404)
