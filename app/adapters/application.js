import JSONAPIAdapter from '@ember-data/adapter/json-api';
import { pluralize } from 'ember-inflector';
import ENV from 'netrunnerdb/config/environment';

export default class ApplicationAdapter extends JSONAPIAdapter {
  host = ENV.API_URL;
  namespace = 'public';

  // Converts Ember's dashes convention convention to Rails' underscores
  pathForType(type) {
    return pluralize(type.replace(/-/g, '_'));
  }
}
