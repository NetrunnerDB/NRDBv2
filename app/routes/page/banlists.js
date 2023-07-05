import Route from '@ember/routing/route';
import { service } from '@ember/service';
// import RSVP from 'rsvp';

export default class PageBanlistsRoute extends Route {
  @service store;

  async model() {
    return await Promise.all([
      this.store.findRecord('format', 'startup', { include: 'restrictions' }),
      this.store.findRecord('format', 'standard', { include: 'restrictions' }),
      this.store.findRecord('format', 'eternal', { include: 'restrictions' }),
    ]);
  }
}
