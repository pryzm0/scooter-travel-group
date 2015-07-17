
var bunyan = require('bunyan');

module.exports = bunyan.createLogger({
  name: 'scootertrip',
  serializers: {
    res: bunyan.stdSerializers.res,
  },
  streams: [
    { level: 'trace', stream: process.stdout },
    { level: 'info', path: 'log/scootertrip.log'},
  ],
});
