import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageBasicSearchRoute extends Route {
  @service store;

  queryParams = {
    display: { refreshModel: true },
    max_records: { refreshModel: true },
    query: { refreshModel: true },
  };

  async model(params) {
    if (params.query) {
      return RSVP.hash({
        printings: this.store.query('printing', {
          filter: { search: params.query },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records || 100 },
        }),
        searchParams: {
          display: 'checklist',
          max_records: 100,
          query: params.query,
        },
      });
    } else {
      return RSVP.hash({
        printings: [],
        searchParams: { display: 'checklist', max_records: 100 },
      });
    }
  }
}
