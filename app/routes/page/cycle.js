import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageCycleRoute extends Route {
  @service store;

  async model(params) {
    return RSVP.hash({
      cycle: this.store.findRecord('card_cycle', params.id),
      printings: this.store.query('printing', {
        filter: { card_cycle_id: params.id },
        include: ['card_set', 'card_type', 'faction'],
        page: { size: 1000 },
      }),
    });
  }
}
