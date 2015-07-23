bunyan = require 'bunyan'
bformat = require 'bunyan-format'

nconf = require './config'

streams = []

if stdoutLevel = nconf.get 'logger:stdout:level'
  bformatMode = nconf.get 'logger:stdout:bformat'
  streams.push {
    level: stdoutLevel
    stream: ((not bformatMode and process.stdout) or
      bformat { outputMode: bformatMode })
  }

if fileLevel = nconf.get 'logger:file:level'
  streams.push {
    level: fileLevel
    path: nconf.get 'logger:file:path'
  }

module.exports = bunyan.createLogger {
  name: nconf.get 'logger:name'
  serializers: bunyan.stdSerializers
  streams: streams
}
