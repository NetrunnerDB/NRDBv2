import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';

export default class ProfileRoute extends Route {
  @service session;

  beforeModel() {
    this.session.singleLogout();
  }
}
