import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class PageSetsRoute extends Route {
  @service store;

  async model() {
    return await this.store.findAll('card-cycle', { include: ['card_sets'] });
  }
}
