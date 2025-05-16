import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class PrivateController extends Controller {
  @service session;

  @action
  logout() {
    this.session.invalidate();
  }
}
