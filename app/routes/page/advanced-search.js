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

    advancement_cost_operator: { refreshModel: true },
    agenda_points_operator: { refreshModel: true },
    base_link_operator: { refreshModel: true },
    cost_operator: { refreshModel: true },
    influence_cost_operator: { refreshModel: true },
    link_provided_operator: { refreshModel: true },
    memory_usage_operator: { refreshModel: true },
    mu_provided_operator: { refreshModel: true },
    num_printed_subroutines_operator: { refreshModel: true },
    position_operator: { refreshModel: true },
    recurring_credits_provided_operator: { refreshModel: true },
    strength_operator: { refreshModel: true },
    trash_cost_operator: { refreshModel: true },

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
      let op = params.position_operator ? params.position_operator : ':';
      filter.push(`position${op}${params.position}`);
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
      let op = params.agenda_points_operator
        ? params.advancement_agenda_points_operator
        : ':';
      filter.push(`agenda_points${op}${params.agenda_points}`);
    }
    if (params.advancement_cost) {
      let op = params.advancement_cost_operator
        ? params.advancement_cost_operator
        : ':';
      let value =
        params.advancement_cost == '-1' ? 'X' : params.advancement_cost;
      filter.push(`advancement_cost${op}${value}`);
    }
    if (params.influence_cost) {
      let op = params.influence_cost_operator
        ? params.influence_cost_operator
        : ':';
      filter.push(`influence_cost${op}${params.influence_cost}`);
    }
    if (params.cost) {
      let op = params.cost_operator ? params.cost_operator : ':';
      let value = params.cost == '-1' ? 'X' : params.cost;
      filter.push(`cost${op}${value}`);
    }
    if (params.base_link) {
      let op = params.base_link_operator ? params.base_link_operator : ':';
      let value = params.base_link == '-1' ? 'X' : params.base_link;
      filter.push(`base_link${op}${value}`);
    }
    if (params.memory_usage) {
      let op = params.memory_usage_operator
        ? params.memory_usage_operator
        : ':';
      let value = params.memory_usage == '-1' ? 'X' : params.memory_usage;
      filter.push(`memory_usage${op}${value}`);
    }
    if (params.strength) {
      let op = params.strength_operator ? params.strength_operator : ':';
      let value = params.strength == '-1' ? 'X' : params.strength;
      filter.push(`strength${op}${value}`);
    }
    if (params.trash_cost) {
      let op = params.trash_cost_operator ? params.trash_cost_operator : ':';
      let value = params.trash_cost == '-1' ? 'X' : params.trash_cost;
      filter.push(`trash_cost${op}${value}`);
    }
    if (params.mu_provided) {
      let op = params.mu_provided_operator ? params.mu_provided_operator : ':';
      let value = params.mu_provided == '-1' ? 'X' : params.mu_provided;
      filter.push(`mu_provided${op}${value}`);
    }
    if (params.recurring_credits_provided) {
      let op = params.recurring_credits_provided_operator
        ? params.recurring_credits_provided_operator
        : ':';
      let value =
        params.recurring_credits_provided == '-1'
          ? 'X'
          : params.recurring_credits_provided;
      filter.push(`recurring_credits_provided${op}${value}`);
    }
    if (params.link_provided) {
      let op = params.link_provided_operator
        ? params.link_provided_operator
        : ':';
      filter.push(`link_provided${op}${params.link_provided}`);
    }
    if (params.num_printed_subroutines) {
      let op = params.num_printed_subroutines_operator
        ? params.num_printed_subroutines_operator
        : ':';
      filter.push(
        `num_printed_subroutines${op}${params.num_printed_subroutines}`,
      );
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
        searchParams: params,
        sides: sides,
        snapshots: snapshots,
      });
    }
  }
}
