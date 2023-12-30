import { inject as service } from '@ember/service';
import OIDCJSONAPIAdapter from 'ember-simple-auth-oidc/adapters/oidc-json-api-adapter';
import { pluralize } from 'ember-inflector';
import ENV from 'netrunnerdb/config/environment';

export default class ApplicationAdapter extends OIDCJSONAPIAdapter {
  @service session;
  host = ENV.API_URL;
  namespace = 'v3/public';

  // Converts Ember's dashes convention convention to Rails' underscores
  pathForType(type) {
    return pluralize(type.replace(/-/g, '_'));
  }

  // Append headers from auth session on JSON::API requests.
  get headers() {
    return { ...this.session.headers };
  }
}
