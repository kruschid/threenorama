var path = require('path'),
    HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  devServer: {
    historyApiFallback: true,
    hot: true,
    inline: true,
    progress: true,
    colors: true,
    contentBase: './build',
    port: 8080,
  },
  entry: "./src/app.coffee",
  output: {
    path: path.resolve(__dirname, "build"),
    // publicPath: "/assets/",
    filename: "assets/bundle.js"
  },
  module: {
      loaders: [
          { test: /\.coffee$/, loader: "coffee" },
          { test: /\.jade$/, loader: "jade" }
      ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      filename: 'index.html',
      template: 'src/index.jade'
    })
  ] // plugins
};