import Controller from '@ember/controller';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default class PrivateProfileController extends Controller {
  @service session;

  @action
  logout() {
    this.session.singleLogout();
  }
}
