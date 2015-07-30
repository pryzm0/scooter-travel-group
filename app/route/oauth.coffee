router = (require 'express').Router()
module.exports = router

nconf = require '../config'
logger = require '../logger'


router.get '/handle_google_response', (req, res) ->
  logger.info req.body, req.query
  res.json req.session
