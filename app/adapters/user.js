import ApplicationAdapter from './application';
import ENV from 'netrunnerdb/config/environment';

export default class UserAdapter extends ApplicationAdapter {
  host = ENV.API_URL;
  namespace = 'v3/private';

  // The API endpoint is /api/v3/private/user and always returns a single record in the data array.
  pathForType() {
    return 'user';
  }
}
