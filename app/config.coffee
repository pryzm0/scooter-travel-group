
module.exports = (require 'nconf')
  .argv()
  .file( file: 'config.json' )
  .defaults {
    host: '127.0.0.1'
    port: 8080
    database:
      url: 'http://127.0.0.1:5984/travelapp'
      requestDefaults:
        auth: { user: 'master', pass: '' }
    cache:
      expire: 7*24*3600
    static:
      serve: false
      dir: {
        '/assets': './www_public/assets'
        '/bower_components': './bower_components'
      }
    logger:
      name: 'rabbit'
      stdout:
        level: 'trace'
        bformat: { outputMode: 'short' }
  }
