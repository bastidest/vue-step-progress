const config = require('./webpack.base.config');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

config.mode = 'production';
config.entry = './src/index.js';
config.output = {
  filename: 'vue-step-progress.min.js',
  library: 'StepProgress',
  libraryTarget: 'umd'
};
config.optimization = {
  minimizer: [
    new UglifyJSPlugin({
      cache: true,
      parallel: true,
      sourceMap: true,
      uglifyOptions: {
        compress: {
          drop_console: true,
        }
      }
    })
  ]
};

module.exports = config;