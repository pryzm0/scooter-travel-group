var express = require('express');
var app = express();

app.use('/vendor', express.static('./bower_components'));
app.use('/', express.static('./www_public'));

app.get('/users', function (req, res) {
  res.json({ users: [1, 2, 3] });
});

module.exports = app;
