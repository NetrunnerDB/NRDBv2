import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  // TODO(plural): Change to a single query free-form field for requests from other places and a structure for everything else.
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
    let filter = [];
    if (params.title) {
      filter.push(`_:"${params.title}"`);
    }
    if (params.text) {
      filter.push(`x:"${params.text}"`);
    }
    if (params.flavor) {
      filter.push(`a:"${params.flavor}"`);
    }
    if (params.latest_printing_only) {
      filter.push(`is_latest_printing:t`);
    }

    return filter.join(' ');
  }

  async model(params) {
    let filter = params.query
      ? this.buildSearchFilter({ title: params.query })
      : this.buildSearchFilter(params);

    if (filter) {
      return RSVP.hash({
        searchParams: params,
        printings: this.store.query('printing', {
          filter: { search: filter },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records || 100 },
        }),
      });
    } else {
      return RSVP.hash({
        printings: [],
      });
    }
  }
}
