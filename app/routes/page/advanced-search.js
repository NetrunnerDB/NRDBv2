import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  queryParams = {
    display: {
      refreshModel: true,
    },
    query: {
      refreshModel: true,
    },
    max_records: {
      refreshModel: true,
    },
    latest_printing_only: {
      refreshModel: true,
    },
    title: {
      refreshModel: true,
    },
    text: {
      refreshModel: true,
    },
    flavor: {
      refreshModel: true,
    },
  };

  buildSearchFilter(params) {
    // Do the silly thing
    let filter = '';
    if (params.title) {
      filter += `title:"${params.title}" `;
    }
    if (params.text) {
      filter += `text:"${params.text}" `;
    }
    if (params.flavor) {
      filter += `flavor:"${params.flavor}" `;
    }

    return filter;
  }

  async model(params) {
    if (params.query || params.title || params.text || params.flavor) {
      return RSVP.hash({
        searchParams: params,
        searchIssued: true,
        printings: this.store.query('printing', {
          filter: { search: this.buildSearchFilter(params) },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records ? params.max_records : 100 },
        }),
      });
    } else {
      return RSVP.hash({
        searchIssued: false
      })
    }
  }
}
