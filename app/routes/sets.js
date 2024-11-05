import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class SetsRoute extends Route {
  @service store;

  async model() {
    return this.store.query('cardCycle', {
      include: ['card_sets'],
      sort: '-position',
    });
  }
}
