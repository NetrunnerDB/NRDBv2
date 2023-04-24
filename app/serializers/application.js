import JSONAPISerializer from '@ember-data/serializer/json-api';
import { decamelize } from '@ember/string';

export default class ApplicationSerializer extends JSONAPISerializer {
  // Converts Rails' underscore convention to camelCase
  keyForAttribute(key) {
    return decamelize(key);
  }
}
