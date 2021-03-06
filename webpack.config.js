'use strict';

var webpack = require('webpack');
var path = require('path');

module.exports = {
  entry: './src/index.js',

  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },

  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        use: [
          'file-loader?name=[name].[ext]'
        ]
      },
      {
        test: /\.elm$/,
        use: [
          'elm-webpack-loader'
        ]
      },
      {
        test: /\.(woff|woff2)?$/,
        use: [
          'url-loader?limit=131072'
        ]
      },
      {
        test: /\.(jpg|png|svg)$/,
        use: [
          'url-loader?limit=131072'
        ]
      },
      {
        test: /\.mp4$/,
        use: [
          'file-loader?name=[name].[ext]'
        ]
      }
    ],
    noParse: /\.(elm|woff|woff2)$/
  },

  plugins: [
    new webpack.optimize.UglifyJsPlugin()
  ]
};
