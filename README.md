# NetrunnerDB v2

This repository contains the second iteration of NetrunnerDB, the card database for Netrunner. It is written using Ember.js.

## Prerequisites

You will need the following things properly installed on your computer.

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) version 18 or 22
- A browser
- [netrunner-api-server](https://github.com/NetrunnerDB/netrunnerdb-api-server) (which comes with its own set of dependencies) cloned in the same parent folder as this repository

## Installation

# TODO corething enable

- `git clone <repository-url>` this repository
- `cd NRDBv2`
- `corepack enable` (see [here](https://yarnpkg.com/getting-started/install) for an explanation, this is required by yarn)
- `yarn install`

## Running / Development

- `yarn start`
- Visit your app at [http://localhost:4200](http://localhost:4200).
- Visit your tests at [http://localhost:4200/tests](http://localhost:4200/tests).

### Code Generators

Make use of the many generators for code, try `ember help generate` for more details

### Running Tests

- `ember test`
- `ember test --server`

### Linting

- `yarn lint`
- `yarn lint:fix`

### Building

- `ember build` (development)
- `ember build --environment production` (production)

`yarn build` runs the production version of `ember build`.

### Deploying

Specify what it takes to deploy your app.

## Further Reading / Useful Links

- [ember.js](https://emberjs.com/)
- [ember-cli](https://cli.emberjs.com/release/)
- Development Browser Extensions
  - [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  - [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
