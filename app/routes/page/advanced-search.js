import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  // TODO(plural): Change to a single query free-form field for requests from other places and a structure for everything else.
  queryParams = {
    additional_cost: { refreshModel: true },
    advanceable: { refreshModel: true },
    advancement_cost: { refreshModel: true },
    agenda_points: { refreshModel: true },
    attribution: { refreshModel: true },
    base_link: { refreshModel: true },
    card_cycle: { refreshModel: true },
    card_pool: { refreshModel: true },
    card_set: { refreshModel: true },
    card_subtype_id: { refreshModel: true },
    card_type_id: { refreshModel: true },
    cost: { refreshModel: true },
    designed_by: { refreshModel: true },
    display: { refreshModel: true },
    faction_id: { refreshModel: true },
    flavor: { refreshModel: true },
    format: { refreshModel: true },
    gains_subroutines: { refreshModel: true },
    illustrator_id: { refreshModel: true },
    influence_cost: { refreshModel: true },
    interrupt: { refreshModel: true },
    is_unique: { refreshModel: true },
    latest_printing_only: { refreshModel: true },
    link_provided: { refreshModel: true },
    max_records: { refreshModel: true },
    memory_usage: { refreshModel: true },
    mu_provided: { refreshModel: true },
    num_printed_subroutines: { refreshModel: true },
    num_printings: { refreshModel: true },
    num_records: { refreshModel: true },
    on_encounter_effect: { refreshModel: true },
    performs_trace: { refreshModel: true },
    position: { refreshModel: true },
    quantity: { refreshModel: true },
    query: { refreshModel: true },
    recurring_credits_provided: { refreshModel: true },
    release_date: { refreshModel: true },
    released_by: { refreshModel: true },
    restriction_id: { refreshModel: true },
    rez_effect: { refreshModel: true },
    side_id: { refreshModel: true },
    snapshot: { refreshModel: true },
    strength: { refreshmodel: true },
    text: { refreshmodel: true },
    title: { refreshModel: true },
    trash_ability: { refreshModel: true },
    trash_cost: { refreshModel: true },
  };

  buildSearchFilter(params) {
    let filter = [];
    if (params.position) {
      filter.push(`position:${params.position}`);
    }
    if (params.quantity) {
      filter.push(`quantity:${params.quantity}`);
    }
    if (params.title) {
      filter.push(`_:"${params.title}"`);
    }
    if (params.card_cycle) {
      filter.push(`card_cycle:"${params.card_cycle}"`);
    }
    if (params.card_set) {
      filter.push(`card_set:"${params.card_set}"`);
    }
    if (params.text) {
      filter.push(`x:"${params.text}"`);
    }
    if (params.flavor) {
      filter.push(`a:"${params.flavor}"`);
    }
    if (params.latest_printing_only) {
      filter.push(`is_latest_printing:${params.latest_printing_only}`);
    }
    if (params.side_id) {
      filter.push(`side:${params.side_id}`);
    }
    if (params.faction_id) {
      filter.push(`faction:${params.faction_id.replaceAll(',', '|')}`);
    }
    if (params.card_type_id) {
      filter.push(`card_type:${params.card_type_id.replaceAll(',', '|')}`);
    }
    if (params.card_subtype_id) {
      filter.push(
        `card_subtype_id:${params.card_subtype_id.replaceAll(',', '|')}`,
      );
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
      filter.push(
        `illustrator_id:${params.illustrator_id.replaceAll(',', '|')}`,
      );
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
    if (params.agenda_points) {
      filter.push(`agenda_points:${params.agenda_points}`);
    }
    if (params.advancement_cost) {
      let value =
        params.advancement_cost == '-1' ? 'X' : params.advancement_cost;
      filter.push(`advancement_cost:${value}`);
    }
    if (params.influence_cost) {
      filter.push(`influence_cost:${params.influence_cost}`);
    }
    if (params.cost) {
      let value = params.cost == '-1' ? 'X' : params.cost;
      filter.push(`cost:${value}`);
    }
    if (params.base_link) {
      let value = params.base_link == '-1' ? 'X' : params.base_link;
      filter.push(`base_link:${value}`);
    }
    if (params.memory_usage) {
      let value = params.memory_usage == '-1' ? 'X' : params.memory_usage;
      filter.push(`memory_usage:${value}`);
    }
    if (params.strength) {
      let value = params.strength == '-1' ? 'X' : params.strength;
      filter.push(`strength:${value}`);
    }
    if (params.trash_cost) {
      let value = params.trash_cost == '-1' ? 'X' : params.trash_cost;
      filter.push(`trash_cost:${value}`);
    }
    if (params.mu_provided) {
      let value = params.mu_provided == '-1' ? 'X' : params.mu_provided;
      filter.push(`mu_provided:${value}`);
    }
    if (params.recurring_credits_provided) {
      let value =
        params.recurring_credits_provided == '-1'
          ? 'X'
          : params.recurring_credits_provided;
      filter.push(`recurring_credits_provided:${value}`);
    }
    if (params.link_provided) {
      filter.push(`link_provided:${params.link_provided}`);
    }
    if (params.num_printed_subroutines) {
      filter.push(`num_printed_subroutines:${params.num_printed_subroutines}`);
    }
    if (params.release_date) {
      filter.push(`release_date:${params.release_date}`);
    }
    if (params.card_pool) {
      filter.push(`card_pool:${params.card_pool.replaceAll(',', '|')}`);
    }
    if (params.format) {
      filter.push(`format:${params.format.replaceAll(',', '|')}`);
    }
    if (params.snapshot) {
      filter.push(`snapshot:${params.snapshot.replaceAll(',', '|')}`);
    }
    if (params.restriction_id) {
      filter.push(
        `restriction_id:${params.restriction_id.replaceAll(',', '|')}`,
      );
    }

    return filter.join(' ');
  }

  async model(params) {
    let filter = params.query
      ? this.buildSearchFilter({ title: params.query })
      : this.buildSearchFilter(params);

    const [
      cardCycles,
      cardPools,
      cardSets,
      cardSubtypes,
      cardTypes,
      factions,
      formats,
      illustrators,
      restrictions,
      sides,
      snapshotsRaw,
    ] = await Promise.all([
      this.store.query('card_cycle', { sort: '-date_release' }),
      this.store.query('card_pool', { sort: 'name' }),
      this.store.query('card_set', { sort: '-date_release' }),
      this.store.query('card_subtype', { sort: 'name' }),
      this.store.query('card_type', { sort: 'name' }),
      this.store.query('faction', { sort: 'name' }),
      this.store.query('format', { sort: 'name' }),
      this.store.query('illustrator', { sort: 'name' }),
      this.store.query('restriction', { sort: '-date_start' }),
      this.store.query('side', { sort: 'name' }),
      this.store.query('snapshot', { sort: 'format_id,-date_start' }),
    ]);

    const formatMap = {};
    formats.forEach((f) => {
      formatMap[f.id] = f.name;
    });
    const cardPoolMap = {};
    cardPools.forEach((p) => {
      cardPoolMap[p.id] = p.name;
    });
    const restrictionMap = {};
    restrictions.forEach((r) => {
      restrictionMap[r.id] = r.name;
    });

    const snapshots = [];
    snapshotsRaw.forEach((s) => {
      let name = `${s.id}: ${formatMap[s.formatId]} / ${
        cardPoolMap[s.cardPoolId]
      }`;
      if (s.restrictionId) {
        name += ` / ${restrictionMap[s.restrictionId]}`;
      }
      name += s.active ? ' (active)' : '';
      snapshots.push({ id: s.id, name: name });
    });

    if (filter) {
      return RSVP.hash({
        cardCycles: cardCycles,
        cardPools: cardPools,
        cardSets: cardSets,
        cardSubtypes: cardSubtypes,
        cardTypes: cardTypes,
        factions: factions,
        formats: formats,
        illustrators: illustrators,
        printings: this.store.query('printing', {
          filter: { search: filter },
          include: ['card_set', 'card_type', 'faction'],
          page: { limit: params.max_records || 100 },
        }),
        restrictions: restrictions,
        searchParams: params,
        sides: sides,
        snapshots: snapshots,
      });
    } else {
      return RSVP.hash({
        cardCycles: cardCycles,
        cardPools: cardPools,
        cardSets: cardSets,
        cardSubtypes: cardSubtypes,
        cardTypes: cardTypes,
        factions: factions,
        formats: formats,
        illustrators: illustrators,
        printings: [],
        restrictions: restrictions,
        searchParams: { display: 'checklist', max_records: 100 },
        sides: sides,
        snapshots: snapshots,
      });
    }
  }
}
