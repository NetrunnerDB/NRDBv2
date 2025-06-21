'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = async function (defaults) {
  const app = new EmberApp(defaults, {
    'ember-bootstrap': {
      insertEmberWormholeElementToDom: false,
      importBootstrapCSS: false,
      include: ['bs-collapse', 'bs-dropdown', 'bs-form', 'bs-tab'],
    },
    'ember-power-select': {
      theme: 'bootstrap',
    },
    'ember-simple-auth': {
      useSessionSetupMethod: true,
    },
    emberData: {
      deprecations: {
        DEPRECATE_STORE_EXTENDS_EMBER_OBJECT: false,
      },
    },
  });

  return app.toTree();
};
