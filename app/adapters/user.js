import ApplicationAdapter from './application';

export default class UserAdapter extends ApplicationAdapter {
  namespace = 'v3/private';
  // The API endpoint is /api/v3/private/user and presents as a singleton.
  pathForType(type) {
    return 'user';
  }
}
