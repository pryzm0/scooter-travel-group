bunyan = require 'bunyan'
bformat = require 'bunyan-format'

nconf = require './config'

module.exports = bunyan.createLogger {
  name: nconf.get 'logger:name'
  serializers: bunyan.stdSerializers
  streams: [
    { level: 'trace', stream: (bformat { outputMode: 'short' }) }
    { level: 'info', path: (nconf.get 'logger:file') }
  ]
}
