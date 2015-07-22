
module.exports = (app) ->
  app.get '/', (req, res) ->
    res.render 'index', req.params

  app.get '/guide', (req, res) ->
    res.render 'guide-list', req.params

  app.get '/guide/:name', (req, res) ->
    res.render 'guide', req.params

  app.get '/route', (req, res) ->
    res.render 'route-list', req.params

  app.get '/route/:name', (req, res) ->
    res.render 'route', req.params
