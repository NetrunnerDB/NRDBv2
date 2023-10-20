import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  queryParams = {
    query: {
      refreshModel: true,
    },
  };

  async model(params) {
    return RSVP.hash({
      printings: this.store.query('printing', {
        filter: { search: params.query },
        include: ['card_set', 'card_type', 'faction'],
        page: { limit: 1000 },
      }),
    });
  }
}
