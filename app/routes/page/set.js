import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageSetRoute extends Route {
  @service store;

  async model(params) {
    return RSVP.hash({
      set: this.store.findRecord('card_set', params.id),
      printings: this.store.query('printing', {
        filter: { card_set_id: params.id },
        include: ['card_type'],
      }),
    });
  }
}
