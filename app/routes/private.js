import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';
import RSVP from 'rsvp';

export default class PrivateRoute extends Route {
  @service session;

  beforeModel(transition) {
    // Set a route to redirect to if the user is not authenticated.
    if (!this.session.data.authenticated.userinfo) {
     this.session.data.nextURL = transition.to.name;
    }
    this.session.requireAuthentication(transition, 'home.login');
  }

  model() {
    return RSVP.hash({
      userinfo: this.session.data.authenticated.userinfo,
    });
  }
}
