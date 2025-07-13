import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class RulingsRoute extends Route {
  @service store;

  async model() {
    return {
      rulings: await this.store.findAll('ruling', {
        include: ['card', 'card.printings'],
        sort: '-updatedAt',
      }),
    };
  }
}
