import Route from '@ember/routing/route';
import { inject as service } from "@ember/service";
import RSVP from 'rsvp';

export default class ProfileRoute extends Route {
  @service session;

  beforeModel(transition) {
    this.session.requireAuthentication(transition, "home.login");
  }

  model() {
    return RSVP.hash({
      userinfo: this.session.data.authenticated.userinfo,
    });
  }
}
