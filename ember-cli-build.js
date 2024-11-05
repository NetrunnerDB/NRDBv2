'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    'ember-bootstrap': {
      bootstrapVersion: 5,
      importBootstrapCSS: true,
    },
    'ember-power-select': {
      theme: 'bootstrap',
    },
    'ember-simple-auth': {
      useSessionSetupMethod: true,
    },
    outputPaths: {
      app: {
        css: {
          color: '/assets/color.css',
          panel: '/assets/panel.css',
          bootstrap_ext: '/assets/bootstrap-ext.css',
        },
      },
    },
  });

  return app.toTree();
};
