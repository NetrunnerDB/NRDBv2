import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  // TODO(plural): Change to a single query free-form field for requests from other places and a structure for everything else.
  queryParams = {
    num_printings: {
      refreshModel: true,
    },
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
    is_unique: {
      refreshModel: true,
    },
    designed_by: {
      refreshModel: true,
    },
    released_by : {
      refreshModel: true,
    },
    attribution: {
      refreshModel: true,
    },
    illustrator_id: {
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
    if (params.is_unique) {
      filter.push(`is_unique:${params.is_unique}`);
    }
    if (params.designed_by) {
      filter.push(`designed_by:${params.designed_by}`);
    }
    if (params.released_by) {
      filter.push(`released_by:${params.released_by}`);
    }
    if (params.attribution) {
      filter.push(`attribution:${params.attribution}`);
    }
    if (params.illustrator_id) {
      filter.push(`illustrator_id:${params.illustrator_id}`);
    }
    if (params.num_printings) {
      filter.push(`num_printings:${params.num_printings}`);
    }

    return filter.join(' ');
  }

  async model(params) {
    let filter = params.query
      ? this.buildSearchFilter({ title: params.query })
      : this.buildSearchFilter(params);

    const [sides, factions, cardTypes, cardSubtypes, illustrators] = await Promise.all([
      this.store.query('side', { sort: 'name' }),
      this.store.query('faction', { sort: 'name' }),
      this.store.query('card_type', { sort: 'name' }),
      this.store.query('card_subtype', { sort: 'name' }),
      this.store.query('illustrator', { sort: 'name' }),
    ]);

    if (filter) {
      return RSVP.hash({
        searchParams: params,
        sides: sides,
        factions: factions,
        cardTypes: cardTypes,
        cardSubtypes: cardSubtypes,
        illustrators: illustrators,
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
        illustrators: illustrators,
        printings: [],
      });
    }
  }
}
