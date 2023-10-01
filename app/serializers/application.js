import JSONAPISerializer from '@ember-data/serializer/json-api';
import { decamelize } from '@ember/string';

export default class ApplicationSerializer extends JSONAPISerializer {
  // Converts Rails' underscore convention to camelCase
  keyForAttribute(key) {
    return decamelize(key);
  }

  // Convert Ember's camelCase back to Rails' underscores
  keyForRelationship(key) {
    return key.replace(/(?:\.?)([A-Z])/g, '_$1').toLowerCase();
  }
}
