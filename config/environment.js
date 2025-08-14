'use strict';

module.exports = function (environment) {
  const ENV = {
    modulePrefix: 'netrunnerdb',
    environment,
    rootURL: '/',
    locationType: 'history',
    EmberENV: {
      EXTEND_PROTOTYPES: false,
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. EMBER_NATIVE_DECORATOR_SUPPORT: true
      },
    },
    'ember-simple-auth-oidc': {
      host: 'https://draft-id.nullsignal.games/realms/nullsignal',
      clientId: 'nrdb-v2-local',
      authPrefix: 'Bearer',
      authEndpoint: '/protocol/openid-connect/auth',
      tokenEndpoint: '/protocol/openid-connect/token',
      endSessionEndpoint: '/protocol/openid-connect/logout',
      userinfoEndpoint: '/protocol/openid-connect/userinfo',
      afterLogoutUri: 'http://localhost:4200/',
      loginHintName: 'custom_login_hint',
      expiresIn: 10 * 60000, // 10m timeout.
      refreshLeeway: 1000,
    },

    // API_URL: 'http://localhost:3000/api/v3',
    API_URL: 'https://api-preview.netrunnerdb.com/api/v3',
    googleFonts: ['Merriweather Sans', 'Outfit', 'Inter', 'Nova Mono'],

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
    ENV.APP.autoboot = false;

    // TODO(plural): Set up ember-simple-auth-oidc testing config here.
  }

  if (environment === 'production') {
    ENV.API_URL = 'https://api-preview.netrunnerdb.com/api/v3';
    ENV['ember-simple-auth-oidc'].clientId = 'nrdb-v2';
    ENV['ember-simple-auth-oidc'].afterLogoutUri =
      'https://v2.netrunnerdb.com/';
  }

  return ENV;
};
