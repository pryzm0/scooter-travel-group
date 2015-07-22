require('coffee-script/register');

var app = require('./app');
var nconf = require('./app/config');
var logger = require('./app/logger');

var http = require('http');

http.createServer(app).listen(nconf.get('port'), function () {
  logger.info('server started at', nconf.get('port'));
});
