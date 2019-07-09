module.exports = function(api) {
  //var currentEnv = api.env()
  var isDevelopmentEnv = api.env('development');
  var isProductionEnv = api.env('production');
  var isTestEnv = api.env('test');

  return {
    presets: [
      ["@babel/preset-env", {
        targets: {
          ie: "11"
        },
        useBuiltIns: 'usage',
        corejs: 3,
      }],
      ['@babel/preset-typescript', {
        isTSX: true,
        allExtensions: true
      }],
      ["@babel/preset-react"],
    ],
    plugins: [
    ],
  };
};
