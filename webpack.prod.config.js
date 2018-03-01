var config = require('./webpack.base.config');

config.mode = 'production';
config.entry = './src/index.js';
config.output = {
  filename: 'vue-step-progress.min.js',
  library: 'StepProgress',
  libraryTarget: 'umd'
};

module.exports = config;