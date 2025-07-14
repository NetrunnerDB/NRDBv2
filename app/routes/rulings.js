import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

const MAX_PAGE_LIMIT = 1000;
export default class RulingsRoute extends Route {
  @service store;

  async model() {
    return hash({
      rulings: this.store.findAll('ruling', {
        include: ['card', 'card.printings'],
        page: { limit: MAX_PAGE_LIMIT },
      }),
    });
  }
}
