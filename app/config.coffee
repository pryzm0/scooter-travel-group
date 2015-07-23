
module.exports = (require 'nconf')
  .argv()
  .file( file: 'config.json' )
  .defaults {
    host: '127.0.0.1'
    port: 8080
    admin: true
    static: true
    session:
      secretKey: 'NOONEKNOWS'
    couch:
      users: 'http://127.0.0.1:5984/_users'
    logger:
      name: 'backend'
      file: 'log/backend.log'
  }
