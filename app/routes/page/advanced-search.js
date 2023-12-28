import Route from '@ember/routing/route';
import { service } from '@ember/service';
import RSVP from 'rsvp';

export default class PageAdvancedSearchRoute extends Route {
  @service store;

  // TODO(plural): Change to a single query free-form field for requests from other places and a structure for everything else.
  queryParams = {
    additional_cost: { refreshModel: true },
    advanceable: { refreshModel: true },
    advancement_cost_operator: { refreshModel: true },
    advancement_cost: { refreshModel: true },
    agenda_points_operator: { refreshModel: true },
    agenda_points: { refreshModel: true },
    attribution_operator: { refreshModel: true },
    attribution: { refreshModel: true },
    base_link_operator: { refreshModel: true },
    base_link: { refreshModel: true },
    card_cycle: { refreshModel: true },
    card_pool: { refreshModel: true },
    card_set: { refreshModel: true },
    card_subtype_id: { refreshModel: true },
    card_type_id: { refreshModel: true },
    cost_operator: { refreshModel: true },
    cost: { refreshModel: true },
    designed_by: { refreshModel: true },
    display: { refreshModel: true },
    faction_id: { refreshModel: true },
    flavor_operator: { refreshModel: true },
    flavor: { refreshModel: true },
    format: { refreshModel: true },
    gains_subroutines: { refreshModel: true },
    illustrator_id: { refreshModel: true },
    influence_cost_operator: { refreshModel: true },
    influence_cost: { refreshModel: true },
    interrupt: { refreshModel: true },
    is_unique: { refreshModel: true },
    latest_printing_only: { refreshModel: true },
    link_provided_operator: { refreshModel: true },
    link_provided: { refreshModel: true },
    max_records: { refreshModel: true },
    memory_usage_operator: { refreshModel: true },
    memory_usage: { refreshModel: true },
    mu_provided_operator: { refreshModel: true },
    mu_provided: { refreshModel: true },
    num_printed_subroutines_operator: { refreshModel: true },
    num_printed_subroutines: { refreshModel: true },
    num_printings_operator: { refreshModel: true },
    num_printings: { refreshModel: true },
    num_records: { refreshModel: true },
    on_encounter_effect: { refreshModel: true },
    performs_trace: { refreshModel: true },
    position_operator: { refreshModel: true },
    position: { refreshModel: true },
    quantity_operator: { refreshModel: true },
    quantity: { refreshModel: true },
    query: { refreshModel: true },
    recurring_credits_provided_operator: { refreshModel: true },
    recurring_credits_provided: { refreshModel: true },
    released_by: { refreshModel: true },
    restriction_id: { refreshModel: true },
    rez_effect: { refreshModel: true },
    side_id: { refreshModel: true },
    snapshot: { refreshModel: true },
    strength_operator: { refreshModel: true },
    strength: { refreshmodel: true },
    text_operator: { refreshmodel: true },
    text: { refreshmodel: true },
    title_operator: { refreshModel: true },
    title: { refreshModel: true },
    trash_ability: { refreshModel: true },
    trash_cost_operator: { refreshModel: true },
    trash_cost: { refreshModel: true },
  };

  // Booleans only use the exact match operator.
  booleanField(p, f, a) {
    let apiField = a ? a : f;
    if (p[f]) {
      return `${apiField}:${p[f]}`;
    }
    return null;
  }

  listField(p, f, a) {
    let apiField = a ? a : f;
    if (p[f]) {
      return `${apiField}:${p[f].replaceAll(',', '|')}`;
    }
    return null;
  }

  // Numeric and text fields have pairs of foo and foo_operator params.
  numberField(p, f, a) {
    let apiField = a ? a : f;
    let value = p[f] == '-1' ? 'X' : p[f];
    if (p[f]) {
      // default to : operator if not specified.
      let op = p[`${f}_operator`] ? p[`${f}_operator`] : ':';
      return `${apiField}${op}${value}`;
    }
    return null;
  }

  textField(p, f, a) {
    let apiField = a ? a : f;
    if (p[f]) {
      let o = `${f}_operator`;
      if ([':', '!'].includes(p[o]) || !p[o]) {
        // Regular or negated LIKE operator.
        return `${apiField}${p[o]}"${p[f]}"`;
      } else if (p[o] == '=~') {
        // Positive regex match.
        return `${apiField}:/${p[f]}/`;
      } else if (p[o] == '!=~') {
        // Negative regex match.
        return `${apiField}!/${p[f]}/`;
      }
    }
    return null;
  }

  buildSearchFilter(params) {
    let filter = [
      this.booleanField(params, 'additional_cost'),
      this.booleanField(params, 'advanceable'),
      this.booleanField(params, 'gains_subroutines'),
      this.booleanField(params, 'interrupt'),
      this.booleanField(params, 'is_unique'),
      this.booleanField(params, 'latest_printing_only', 'is_latest_printing'),
      this.booleanField(params, 'on_encounter_effect'),
      this.booleanField(params, 'performs_trace'),
      this.booleanField(params, 'rez_effect'),
      this.booleanField(params, 'side_id', 'side'),
      this.booleanField(params, 'trash_ability'),
      this.listField(params, 'card_cycle'),
      this.listField(params, 'card_pool'),
      this.listField(params, 'card_set'),
      this.listField(params, 'card_subtype_id'),
      this.listField(params, 'card_type_id', 'card_type'),
      this.listField(params, 'designed_by'),
      this.listField(params, 'faction_id', 'faction'),
      this.listField(params, 'format'),
      this.listField(params, 'illustrator_id'),
      this.listField(params, 'released_by'),
      this.listField(params, 'restriction_id'),
      this.listField(params, 'snapshot'),
      this.numberField(params, 'advancement_cost'),
      this.numberField(params, 'agenda_points'),
      this.numberField(params, 'base_link'),
      this.numberField(params, 'cost'),
      this.numberField(params, 'influence_cost'),
      this.numberField(params, 'link_provided'),
      this.numberField(params, 'memory_usage'),
      this.numberField(params, 'mu_provided'),
      this.numberField(params, 'num_printed_subroutines'),
      this.numberField(params, 'num_printings'),
      this.numberField(params, 'position'),
      this.numberField(params, 'quantity'),
      this.numberField(params, 'recurring_credits_provided'),
      this.numberField(params, 'strength'),
      this.numberField(params, 'trash_cost'),
      this.textField(params, 'attribution'),
      this.textField(params, 'flavor'),
      this.textField(params, 'text'),
      this.textField(params, 'title', '_'),
    ].filter((x) => x !== null);

    return filter.join(' ');
  }

  async model(params) {
    let filter = this.buildSearchFilter(params);

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
