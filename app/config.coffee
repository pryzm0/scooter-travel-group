
module.exports = (require 'nconf')
  .argv()
  .file( file: 'config.json' )
  .defaults {
    host: '127.0.0.1'
    port: 8080
    admin: true
    routes: {
      '/': 'route/index'
      # '/auth': 'route/oauth'
      '/pub': 'route/publish'
    }
    session:
      secret: '=/='
      resave: false
      saveUninitialized: false
    couch:
      users: 'http://127.0.0.1:5984/_users'
      adminRoles: ['admin']
      request_defaults:
        auth:
          user: 'master',
          pass: '=/='
    database:
      url: 'http://127.0.0.1:5984/travelapp'
      requestDefaults:
        auth:
          user: 'master',
          pass: '=/='
    static:
      serve: true
      dir: {
        '/assets': './www_public/assets'
        '/admin': './www_public/admin'
        '/bower_components': './bower_components'
      }
    logger:
      name: 'rabbit'
      debugRequest: false
      stdout:
        level: 'trace'
        bformat:
          outputMode: 'short'
      file:
        level: 'info'
        path: 'log/rabbit.log'
    grant:
      server:
        protocol: 'https'
        host: 'dev.example.com'
      google:
        key: '=/='
        secret: '=/='
        scope: ['profile']
        callback: '/handle_google_response'
  }
