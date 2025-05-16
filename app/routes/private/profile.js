import { service } from '@ember/service';
import Route from '@ember/routing/route';
import RSVP from 'rsvp';

export default class ProfileRoute extends Route {
  @service session;
  @service store;

  model() {
    return RSVP.hash({
      userinfo: this.session.data.authenticated.userinfo,
      // Pluck the single object out of the user response.
      user: this.store.query('user', {}).then((r) => r[0]),
    });
  }
}
