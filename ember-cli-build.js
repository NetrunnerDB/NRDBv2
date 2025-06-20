'use strict';;
const EmberApp = require('ember-cli/lib/broccoli/ember-app');

const {
  compatBuild
} = require("@embroider/compat");

module.exports = async function (defaults) {
  const {
    buildOnce
  } = await import("@embroider/vite");

  const app = new EmberApp(defaults, {
    'ember-bootstrap': {
      insertEmberWormholeElementToDom: false,
      bootstrapVersion: 5,
      importBootstrapCSS: true,
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

  return compatBuild(app, buildOnce);
};
