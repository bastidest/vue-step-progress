var config = require('./webpack.base.config');
var path = require('path');

config.mode = 'development';
config.entry = './dev/index.js';
config.output = {
  path: path.resolve('dist') + '/',
  publicPath: 'dist',
  filename: 'bundle.js'
};

module.exports = config;