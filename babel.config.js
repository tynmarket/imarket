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
      isDevelopmentEnv && [
        require('@babel/preset-env').default,
        {
          targets: 'last 2 Chrome versions',
          useBuiltIns: 'usage',
        },
      ],
      isProductionEnv && [
        require('@babel/preset-env').default,
        {
          forceAllTransforms: true,
          useBuiltIns: 'entry',
          modules: false,
          exclude: ['transform-typeof-symbol'],
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
      // require('babel-plugin-macros'),
      // require('@babel/plugin-syntax-dynamic-import').default,
      //isTestEnv && require('babel-plugin-dynamic-import-node'),
      //require('@babel/plugin-transform-destructuring').default,
      /*
      [
        require('@babel/plugin-proposal-class-properties').default,
        {
          loose: true
        }
      ],
      */
      /*
      [
        require('@babel/plugin-proposal-object-rest-spread').default,
        {
          useBuiltIns: true
        }
      ],
      */
      /*
      [
        require('@babel/plugin-transform-runtime').default,
        {
          helpers: false,
          regenerator: true
        }
      ],
      */
      /*
      [
        require('@babel/plugin-transform-regenerator').default,
        {
          async: false
        }
      ],
      */
      /*
      isProductionEnv && [
        require('babel-plugin-transform-react-remove-prop-types').default,
        {
          removeImport: true
        }
      ]
      */
    ].filter(Boolean),
  };
};
