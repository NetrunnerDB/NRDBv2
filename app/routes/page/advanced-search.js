import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  // TODO(plural): Change to a single query free-form field for requests from other places and a structure for everything else.
  queryParams = {
    additional_cost: { refreshModel: true },
    advanceable: { refreshModel: true },
    attribution: { refreshModel: true },
    card_subtype_id: { refreshModel: true },
    card_type_id: { refreshModel: true },
    designed_by: { refreshModel: true },
    display: { refreshModel: true },
    faction_id: { refreshModel: true },
    flavor: { refreshModel: true },
    gains_subroutines: { refreshModel: true },
    illustrator_id: { refreshModel: true },
    interrupt: { refreshModel: true },
    is_unique: { refreshModel: true },
    latest_printing_only: { refreshModel: true },
    max_records: { refreshModel: true },
    num_printings: { refreshModel: true },
    on_encounter_effect: { refreshModel: true },
    performs_trace: { refreshModel: true },
    query: { refreshModel: true },
    released_by: { refreshModel: true },
    rez_effect: { refreshModel: true },
    side_id: { refreshModel: true },
    text: { refreshModel: true },
    title: { refreshModel: true },
    trash_ability: { refreshModel: true },
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
    if (params.additional_cost) {
      filter.push(`additional_cost:t`);
    }
    if (params.advanceable) {
      filter.push(`advanceable:t`);
    }
    if (params.gains_subroutines) {
      filter.push(`gains_subroutines:t`);
    }
    if (params.interrupt) {
      filter.push(`interrupt:t`);
    }
    if (params.on_encounter_effect) {
      filter.push(`on_encounter_effect:t`);
    }
    if (params.performs_trace) {
      filter.push(`performs_trace:t`);
    }
    if (params.rez_effect) {
      filter.push(`rez_effect:t`);
    }
    if (params.trash_ability) {
      filter.push(`trash_ability:t`);
    }

    return filter.join(' ');
  }

  async model(params) {
    const isUnique = [
      { id: 't', name: 'Yes' },
      { id: 'f', name: 'No' },
    ];
    const numPrintings = [
      { id: '', name: 'Any' },
      { id: 1, name: 1 },
      { id: 2, name: 2 },
      { id: 3, name: 3 },
      { id: 4, name: 4 },
      { id: 5, name: 5 },
      { id: 6, name: 6 },
    ];
    const numRecords = [
      { id: 25, name: 25 },
      { id: 50, name: 50 },
      { id: 100, name: 100 },
      { id: 250, name: 250 },
      { id: 1000, name: 1000 },
      { id: 5000, name: 5000 },
    ];
    const orgs = [
      { id: 'null_signal_games', name: 'Null Signal Games' },
      { id: 'fantasy_flight_games', name: 'Fantasy Flight Games' },
    ];

    let filter = params.query
      ? this.buildSearchFilter({ title: params.query })
      : this.buildSearchFilter(params);

    const [cardSubtypes, cardTypes, factions, illustrators, sides] =
      await Promise.all([
        this.store.query('card_subtype', { sort: 'name' }),
        this.store.query('card_type', { sort: 'name' }),
        this.store.query('faction', { sort: 'name' }),
        this.store.query('illustrator', { sort: 'name' }),
        this.store.query('side', { sort: 'name' }),
      ]);

    if (filter) {
      return RSVP.hash({
        cardSubtypes: cardSubtypes,
        cardTypes: cardTypes,
        factions: factions,
        illustrators: illustrators,
        isUnique: isUnique,
        numPrintings: numPrintings,
        numRecords: numRecords,
        orgs: orgs,
        printings: this.store.query('printing', {
          filter: { search: filter },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records || 100 },
        }),
        searchParams: params,
        sides: sides,
      });
    } else {
      return RSVP.hash({
        sides: sides,
        factions: factions,
        cardTypes: cardTypes,
        cardSubtypes: cardSubtypes,
        illustrators: illustrators,
        isUnique: isUnique,
        numPrintings: numPrintings,
        numRecords: numRecords,
        orgs: orgs,
        printings: [],
      });
    }
  }
}
