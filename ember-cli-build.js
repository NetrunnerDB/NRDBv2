'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    'ember-bootstrap': {
      bootstrapVersion: 5,
      importBootstrapCSS: true,
    },
    outputPaths: {
      app: {
        css: {
          'netrunner-font': '/assets/netrunner-font.css',
          color: '/assets/color.css',
        },
      },
    },
  });

  return app.toTree();
};
