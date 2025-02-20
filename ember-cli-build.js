'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = async function (defaults) {
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
  });

  return app.toTree();
};
