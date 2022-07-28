const path = require('path');
const express = require('express');
const app = express();
const http = require('http');
const webpack = require('webpack');
const webpackMiddleware = require('webpack-dev-middleware');

app.set('views', path.resolve(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(webpackMiddleware(webpack(
  require('../webpack.dev.config.js')
), {
  publicPath: '/dist/'
}));

app.use('/esm', express.static(path.resolve(__dirname, 'esm')));
app.use('/dist-static', express.static(path.resolve(__dirname, '../dist')));

app.get('/', function (req, res) {
  res.render('index');
});

http.createServer(app).listen(3000);
