import ApplicationAdapter from './application';
import ENV from 'netrunnerdb/config/environment';

export default class DeckAdapter extends ApplicationAdapter {
  host = ENV.API_URL;
  namespace = 'v3/private';
}
