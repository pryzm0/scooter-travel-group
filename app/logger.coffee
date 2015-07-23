bunyan = require 'bunyan'
bformat = require 'bunyan-format'

nconf = require './config'

streams = []

if stdoutLevel = nconf.get 'logger:stdout:level'
  if bformatOpts = nconf.get 'logger:stdout:bformat'
    stdout = bformat bformatOpts
  else
    stdout = process.stdout

  streams.push {
    level: stdoutLevel
    stream: stdout
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
