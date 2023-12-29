import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';

export default class ProfileRoute extends Route {
  @service session;

  beforeModel(transition) {
    this.session.singleLogout()
  }
}
