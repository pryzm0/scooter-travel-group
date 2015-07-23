
module.exports = (require 'nconf')
  .argv()
  .file( file: 'config.json' )
  .defaults {
    host: '127.0.0.1'
    port: 8080
    admin: true
    session:
      secretKey: '--/--'
    couch:
      users: 'http://127.0.0.1:5984/_users'
    static:
      serve: true
      dir: {
        '/bower_components': './bower_components'
        '/assets': './www_public/assets'
      }
    logger:
      name: 'rabbit'
      debugRequest: false
      stdout:
        level: 'trace'
        bformat: 'short'
      file:
        level: 'info'
        path: 'log/rabbit.log'
  }
