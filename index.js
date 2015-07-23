require('coffee-script/register');

var http = require('http');
var app = require('./app');

var host = app.conf.get('host'),
  port = app.conf.get('port');

http.createServer(app).listen(port, host, function () {
  app.logger.info('server started at', host + ':' + port);
});
