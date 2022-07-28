const path = require('path');
const webpack = require('webpack');

const { VueLoaderPlugin } = require('vue-loader');

module.exports = {
  mode: 'development',
  entry: './dev/index.js',
  output: {
    path: path.resolve('dist') + '/',
    publicPath: 'dist',
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      },
      {
        test: /\.sass$/,
        use: [
          'style-loader',
          'css-loader',
          {
            loader: 'sass-loader',
            options: {
              sassOptions: {
                indentedSyntax: true
              }
            }
          }
        ]
      },
      {
        test: /\.pug$/,
        loader: 'pug-plain-loader'
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      }
    ],
  },
  resolve: {
    modules: [
      'node_modules',
      'vue'
    ]
  },
  plugins: [
    new VueLoaderPlugin(),
    new webpack.DefinePlugin({
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false,
    }),
  ],
  devtool: 'source-map',
  target: 'web'
};
