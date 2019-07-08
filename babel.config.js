module.exports = function(api) {
  //var currentEnv = api.env()
  var isDevelopmentEnv = api.env('development');
  var isProductionEnv = api.env('production');
  var isTestEnv = api.env('test');

  return {
    presets: [
      isTestEnv && [
        require('@babel/preset-env').default,
        {
          targets: {
            node: 'current',
          },
        },
      ],
      (isProductionEnv || isDevelopmentEnv) && [
        require('@babel/preset-env').default,
        {
          targets: {
            ie: "11",
          },
          useBuiltIns: 'usage',
          corejs: 3,
          modules: false,
        },
      ],
      [
        require('@babel/preset-react').default,
        {
          development: isDevelopmentEnv || isTestEnv,
          useBuiltIns: true,
        },
      ],
    ].filter(Boolean),
    plugins: [
    ].filter(Boolean),
  };
};
