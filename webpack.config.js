// node_modules/.bin/webpack-dev-server  -d --config webpack.config.development.js

const path = require('path');
const webpack = require('webpack');

const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const WebpackAssetsManifest = require('webpack-assets-manifest');
const CaseSensitivePathsPlugin = require('case-sensitive-paths-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin

module.exports = (env, {mode}) => {
  isDevelopmentEnv = mode === 'development';
  isProductionEnv = mode === 'production';

  const devConfig = {
    cache: true,
    devtool: 'cheap-module-source-map',
    devServer: {
      clientLogLevel: 'none',
      compress: true,
      quiet: false,
      disableHostCheck: true,
      host: 'localhost',
      port: 3035,
      https: false,
      hot: false,
      contentBase: path.join(__dirname, 'public/packs'),
      inline: true,
      useLocalIp: false,
      public: 'localhost:3035',
      publicPath: '/packs/',
      historyApiFallback: { disableDotRule: true },
      headers: { 'Access-Control-Allow-Origin': '*' },
      overlay: true,
      stats: {
        entrypoints: false,
        errorDetails: false,
        modules: false,
        moduleTrace: false,
      },
      watchOptions: { ignored: '/node_modules/' },
    },
  };

  const prodConfig = {
    bail: true,
    optimization: {
      minimizer: [
        new TerserPlugin({
          parallel: true,
          cache: true,
          sourceMap: false, // TODO 引数
        })
      ]
    },
  };

  const config = {
    entry: {
      application: path.join(__dirname, 'app/javascript/packs/application.js'),
    },

    output: {
      filename: '[name]-[hash].js',
      path: path.join(__dirname, 'public/packs'),
      publicPath: '/packs/',
    },

    resolve: {
      extensions: [
        '.tsx',
        '.ts',
        '.jsx',
        '.mjs',
        '.js',
        '.sass',
        '.scss',
        '.css',
        '.png',
        '.svg',
        '.gif',
        '.jpeg',
        '.jpg',
      ],
      modules: [path.join(__dirname, 'app/javascript'), 'node_modules'],
    },
    module: {
      strictExportPresence: true,
      rules: [
        {
          test: /\.(ts|tsx)$/,
          exclude: /node_modules/,
          use: [
            {
              loader: 'ts-loader',
            },
          ],
        },
        {
          test: /(.jpg|.jpeg|.png|.gif|.tiff|.ico|.svg|.eot|.otf|.ttf|.woff|.woff2)$/i,
          use: [
            {
              loader: 'file-loader',
              options: {
                name: '[path][name]-[hash].[ext]',
                context: 'app/javascript',
              },
            },
          ],
        },
        {
          test: /\.(css)$/i,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: 'css-loader',
              options: {
                sourceMap: true,
                importLoaders: 2,
                localIdentName: '[name]__[local]___[hash:base64:5]',
                modules: false,
              },
            },
          ],
          sideEffects: true,
        },
        {
          test: /\.(scss|sass)$/i,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: 'css-loader',
              options: {
                sourceMap: true,
                importLoaders: 2,
                localIdentName: '[name]__[local]___[hash:base64:5]',
                modules: false,
              },
            },
            { loader: 'sass-loader', options: { sourceMap: true } },
          ],
          sideEffects: true,
        },
        {
          test: /\.(js|mjs)$/,
          exclude: /@babel(?:\/|\\{1,2})runtime/,
          use: [
            {
              loader: 'babel-loader',
              options: {
                presets: [['@babel/preset-env', { modules: false }]], // 外すとエラー
                cacheDirectory: true,
                cacheCompression: isProductionEnv,
                compact: false,
              },
            },
          ],
        },
        {
          test: /\.(js|jsx|mjs)?(\.erb)?$/,
          exclude: /node_modules/,
          use: [
            {
              loader: 'babel-loader',
              options: {
                cacheDirectory: true,
                cacheCompression: isProductionEnv,
                compact: isProductionEnv,
              },
            },
          ],
        },
      ],
    },
    plugins: [
      new webpack.EnvironmentPlugin(JSON.parse(JSON.stringify(process.env))),
      new CaseSensitivePathsPlugin(),
      new MiniCssExtractPlugin({
        filename: '[name]-[contenthash:8].css',
      }),
      new WebpackAssetsManifest({
        writeToDisk: true,
        publicPath: true,
      }),
      new OptimizeCSSAssetsPlugin(),
      new BundleAnalyzerPlugin(),
    ],
  };

  if (isProductionEnv) {
    return { ...config, ...prodConfig };
  } else {
    return { ...config, ...devConfig };
  };
};
