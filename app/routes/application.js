import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class ApplicationRoute extends Route {
  @service session;
  @service intl;

  async beforeModel() {
    await this.session.setup();
    this.intl.setLocale(['pt-PT', 'en-US']);
  }
}
