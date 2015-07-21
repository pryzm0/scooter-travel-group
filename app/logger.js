
var bunyan = require('bunyan');
var bformat = require('bunyan-format'),
  formatOut = bformat({ outputMode: 'short' });

module.exports = bunyan.createLogger({
  name: 'scootertrip',
  serializers: {
    res: bunyan.stdSerializers.res,
  },
  streams: [
    { level: 'trace', stream: formatOut },
    { level: 'info', path: 'log/scootertrip.log' },
  ],
});
