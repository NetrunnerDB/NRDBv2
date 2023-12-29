import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';
import RSVP from 'rsvp';

export default class ProfileRoute extends Route {
  @service session;
  @service store;

  model() {
    return RSVP.hash({
      userinfo: this.session.data.authenticated.userinfo,
      user: this.store.query('user', {}),
    });
  }
}
