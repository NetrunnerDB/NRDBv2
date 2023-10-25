import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  queryParams = {
    query: {
      refreshModel: true,
    },
    max_records: {
      refreshModel: true,
    },
    latest_printing_only: {
      refreshModel: true,
    },
  };

  async model(params) {
    if (params.query) {
      return RSVP.hash({
        searchParams: {
          query: params.query,
          max_records: params.max_records ? params.max_records : 100,
          latest_printing_only: params.latest_printing_only,
        },
        printings: this.store.query('printing', {
          filter: { search: params.query },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records ? params.max_records : 100 },
        }),
      });
    }
  }
}
