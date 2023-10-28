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
    side_id: {
      refreshModel: true,
    },
    faction_id: {
      refreshModel: true,
    },
    card_type_id: {
      refreshModel: true,
    },
    card_subtype_id: {
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
    if (params.side_id) {
      filter.push(`side:${params.side_id}`);
    }
    if (params.faction_id) {
      filter.push(`faction:${params.faction_id}`);
    }
    if (params.card_type_id) {
      filter.push(`card_type:${params.card_type_id}`);
    }
    if (params.card_subtype_id) {
      filter.push(`card_subtype_id:${params.card_subtype_id}`);
    }

    return filter.join(' ');
  }

  async model(params) {
    let filter = params.query
      ? this.buildSearchFilter({ title: params.query })
      : this.buildSearchFilter(params);

    const [sides, factions, cardTypes, cardSubtypes] = await Promise.all([
      this.store.query('side', {sort: 'name'}),
      this.store.query('faction', {sort: 'name'}),
      this.store.query('card_type', {sort: 'name'}),
      this.store.query('card_subtype', {sort: 'name'}),
    ]);

    if (filter) {
      return RSVP.hash({
        searchParams: params,
        sides: sides,
        factions: factions,
        cardTypes: cardTypes,
        cardSubtypes: cardSubtypes,
        printings: this.store.query('printing', {
          filter: { search: filter },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records || 100 },
        }),
      });
    } else {
      return RSVP.hash({
        sides: sides,
        factions: factions,
        cardTypes: cardTypes,
        cardSubtypes: cardSubtypes,
        printings: [],
      });
    }
  }
}
