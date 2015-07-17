
var express = require('express');
var http = require('http');

var nconf = require('./app/config');
var logger = require('./app/logger');

var app = express();

app.use('/static', express.static('./bower_components'));
app.use('/static', express.static('./www'));

http.createServer(app).listen(nconf.get('port'), function () {
  logger.info('server started at', nconf.get('port'));
});
