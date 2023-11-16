import Component from '@glimmer/component';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import Icon from '../icon';
import BsForm from 'ember-bootstrap/components/bs-form';
import PowerSelect from 'ember-power-select/components/power-select';
import PowerSelectMultiple from 'ember-power-select/components/power-select-multiple';

export default class SearchFormComponent extends Component {
  @service router;
  @tracked searchParams;

  // TODO(plural): sort params to aid caching.
  constructor() {
    super(...arguments);
    this.searchParams = this.args.searchParams;
    let p = this.searchParams;
    let a = this.args.searchParams;

    p.additional_cost = this.single(a.additional_cost, this.yesNo);
    p.advanceable = this.single(a.advanceable, this.yesNo);
    p.card_cycle = this.multi(a.card_cycle, this.args.cardCycles);
    p.card_pool = this.multi(a.card_pool, this.args.cardPools);
    p.card_set = this.multi(a.card_set, this.args.cardSets);
    p.card_subtype_id = this.multi(a.card_subtype_id, this.args.cardSubtypes);
    p.card_type_id = this.multi(a.card_type_id, this.args.cardTypes);
    p.designed_by = this.single(a.designed_by, this.orgs);
    p.display = this.single(a.display, this.displayOptions);
    p.faction_id = this.multi(a.faction_id, this.args.factions);
    p.format = this.multi(a.format, this.args.formats);
    p.gains_subroutines = this.single(a.gains_subroutines, this.yesNo);
    p.illustrator_id = this.multi(a.illustrator_id, this.args.illustrators);
    p.interrupt = this.single(a.interrupt, this.yesNo);
    p.is_unique = this.single(a.is_unique, this.yesNo);
    p.latest_printing_only = this.single(a.latest_printing_only, this.yesNo);
    p.num_printings = this.single(a.num_printings, this.oneToSix);
    p.on_encounter_effect = this.single(a.on_encounter_effect, this.yesNo);
    p.performs_trace = this.single(a.performs_trace, this.yesNo);
    p.quantity = this.single(a.quantity, this.oneToSix);
    p.released_by = this.single(a.released_by, this.orgs);
    p.restriction_id = this.multi(a.restriction_id, this.args.restrictions);
    p.rez_effect = this.single(a.rez_effect, this.yesNo);
    p.side_id = this.single(a.side_id, this.args.sides);
    p.snapshot = this.multi(a.snapshot, this.args.snapshots);
    p.trash_ability = this.single(a.trash_ability, this.yesNo);
  }

  // Provide value for single select element.
  single(param, objects) {
    if (!param) {
      return null;
    }
    let id = param.toLowerCase();
    let matches = objects.filter((x) => x.id == id);
    if (matches.length > 0) {
      return matches[0];
    }
    return null;
  }

  // Provide values for multi-select element.
  multi(param, objects) {
    if (!param) {
      return [];
    }
    let ids = param.toLowerCase().split?.(',');
    return objects.filter((x) => ids.includes(x.id));
  }

  displayOptions = [
    { id: 'checklist', name: 'Checklist' },
    { id: 'full', name: 'Full Card' },
    { id: 'images', name: 'Image Only' },
    { id: 'text', name: 'Text Only' },
  ];
  yesNo = [
    { id: 't', name: 'Yes' },
    { id: 'f', name: 'No' },
  ];
  oneToSix = [
    { id: '', name: 'Any' },
    { id: 1, name: 1 },
    { id: 2, name: 2 },
    { id: 3, name: 3 },
    { id: 4, name: 4 },
    { id: 5, name: 5 },
    { id: 6, name: 6 },
  ];
  orgs = [
    { id: 'null_signal_games', name: 'Null Signal Games' },
    { id: 'fantasy_flight_games', name: 'Fantasy Flight Games' },
  ];
  numRecords = [25, 50, 100, 250, 500, 1000, 5000];

  @action doSearch() {
    let p = this.searchParams;
    let q = { max_records: p.max_records, display: p.display.id };

    if (p.flavor && p.flavor.trim().length > 0) {
      q.flavor = p.flavor;
    }
    if (p.title && p.title.trim().length > 0) {
      q.title = p.title;
    }
    if (p.text && p.text.trim().length > 0) {
      q.text = p.text;
    }
    if (p.position && p.position.trim().length > 0) {
      q.position = p.position;
    }
    if (p.side_id) {
      q.side_id = p.side_id.id;
    }
    if (p.faction_id && p.faction_id.length > 0) {
      q.faction_id = p.faction_id.map?.((x) => x.id);
    }
    if (p.card_type_id && p.card_type_id.length > 0) {
      q.card_type_id = p.card_type_id.map?.((x) => x.id);
    }
    if (p.card_subtype_id && p.card_subtype_id.length > 0) {
      q.card_subtype_id = p.card_subtype_id.map?.((x) => x.id);
    }
    if (p.illustrator_id && p.illustrator_id.length > 0) {
      q.illustrator_id = p.illustrator_id.map?.((x) => x.id);
    }

    if (p.influence_cost && p.influence_cost.trim().length > 0) {
      q.influence_cost = p.influence_cost;
    }
    if (p.advancement_cost && p.advancement_cost.trim().length > 0) {
      q.advancement_cost = p.advancement_cost;
    }
    if (p.agenda_points && p.agenda_points.trim().length > 0) {
      q.agenda_points = p.agenda_points;
    }
    if (p.base_link && p.base_link.trim().length > 0) {
      q.base_link = p.base_link;
    }
    if (p.attribution && p.attribution.trim().length > 0) {
      q.attribution = p.attribution;
    }
    if (p.memory_usage && p.memory_usage.trim().length > 0) {
      q.memory_usage = p.memory_usage;
    }
    if (p.strength && p.strength.trim().length > 0) {
      q.strength = p.strength;
    }
    if (p.trash_cost && p.trash_cost.trim().length > 0) {
      q.trash_cost = p.trash_cost;
    }
    if (p.cost && p.cost.trim().length > 0) {
      q.cost = p.cost;
    }
    if (p.link_provided && p.link_provided.trim().length > 0) {
      q.link_provided = p.link_provided;
    }
    if (p.mu_provided && p.mu_provided.trim().length > 0) {
      q.mu_provided = p.mu_provided;
    }
    if (
      p.num_printed_subroutines &&
      p.num_printed_subroutines.trim().length > 0
    ) {
      q.num_printed_subroutines = p.num_printed_subroutines;
    }
    if (
      p.recurring_credits_provided &&
      p.recurring_credits_provided.trim().length > 0
    ) {
      q.recurring_credits_provided = p.recurring_credits_provided;
    }
    q.num_printings = p.num_printings ? p.num_printings.id : null;
    q.is_unique = p.is_unique ? p.is_unique.id : null;
    q.quantity = p.quantity ? p.quantity.id : null;
    q.designed_by = p.designed_by ? p.designed_by.id : null;
    q.released_by = p.released_by ? p.released_by.id : null;

    q.latest_printing_only = p.latest_printing_only
      ? p.latest_printing_only.id
      : null;
    q.additional_cost = p.additional_cost ? p.additional_cost.id : null;
    q.advanceable = p.advanceable ? p.advanceable.id : null;
    q.gains_subroutines = p.gains_subroutines ? p.gains_subroutines.id : null;
    q.interrupt = p.interrupt ? p.interrupt.id : null;
    q.on_encounter_effect = p.on_encounter_effect
      ? p.on_encounter_effect.id
      : null;
    q.performs_trace = p.performs_trace ? p.performs_trace.id : null;
    q.rez_effect = p.rez_effect ? p.rez_effect.id : null;
    q.trash_ability = p.trash_ability ? p.trash_ability.id : null;

    if (p.card_cycle) {
      if (p.card_cycle.length != 0) {
        q.card_cycle = p.card_cycle.map((x) => x.id);
      } else {
        q.card_cycle = null;
      }
    }
    if (p.card_set) {
      if (p.card_set.length != 0) {
        q.card_set = p.card_set.map((x) => x.id);
      } else {
        q.card_set = null;
      }
    }

    if (p.snapshot && p.snapshot.length > 0) {
      q.snapshot = p.snapshot.map?.((x) => x.id);
    }
    if (p.format && p.format.length > 0) {
      q.format = p.format.map?.((x) => x.id);
    }
    if (p.card_pool && p.card_pool.length > 0) {
      q.card_pool = p.card_pool.map?.((x) => x.id);
    }
    if (p.restriction_id && p.restriction_id.length > 0) {
      q.restriction_id = p.restriction_id.map?.((x) => x.id);
    }

    this.router.transitionTo(this.router.currentRouteName, {
      queryParams: q,
    });
  }

  <template>
    <h1>Search Form</h1>

    {{#if @searchParams.query}}
      <p>Free form query is: <strong>{{@searchParams.query}}</strong></p>
    {{/if}}

    <BsForm
      @formLayout='vertical'
      @onSubmit={{this.doSearch}}
      @model={{this.searchParams}}
      as |form|
    >
      <fieldset>
        <legend>Title &amp; Text</legend>
        <div class='row'>
          <div class='col-sm-6'>
            <form.element
              @controlType='text'
              @label='Title'
              @property='title'
            />
          </div>
          <div class='col-sm-6'>
            <form.element @controlType='text' @label='Text' @property='text' />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Printing Attributes</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element @label='Latest Printing Only?' @property='latest_printing_only' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.latest_printing_only}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.latest_printing_only)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Position In Set'
              @property='position'
            />
          </div>
          <div class='col-sm-3'>
            <form.element @label='Quantity In Set' @property='quantity' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.oneToSix}}
                @selected={{this.searchParams.quantity}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.quantity)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Num Printings'
              @property='num_printings'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.oneToSix}}
                @selected={{this.searchParams.num_printings}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.num_printings)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-6'>
            <form.element
              @controlType='text'
              @label='Flavor Text'
              @property='flavor'
            />
          </div>
          <div class='col-sm-6'>
            <form.element @label='Illustrators' @property='illustrator_id' as |el|>
              <PowerSelectMultiple
                @options={{@illustrators}}
                @selected={{this.searchParams.illustrator_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.illustrator_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Card Attributes</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element @label='Side' @property='side_id' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{@sides}}
                @selected={{this.searchParams.side_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.side_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Faction' @property='faction_id' as |el|>
              <PowerSelectMultiple
                @options={{@factions}}
                @selected={{this.searchParams.faction_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.faction_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Card Type' @property='card_type_id' as |el|>
              <PowerSelectMultiple
                @options={{@cardTypes}}
                @selected={{this.searchParams.card_type_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.card_type_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Card Subtype'
              @property='card_subtype_id'
              as |el|
            >
              <PowerSelectMultiple
                @options={{@cardSubtypes}}
                @selected={{this.searchParams.card_subtype_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.card_subtype_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element @label='Unique?' @property='is_unique' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.is_unique}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.is_unique)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Influence'
              @property='influence_cost'
            />
          </div>
          <div class='col-sm-3'>
            <form.element @controlType='text' @label='Cost' @property='cost' />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Advancement Requirement'
              @property='advancement_cost'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Agenda Points'
              @property='agenda_points'
            />
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Base Link'
              @property='base_link'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Memory Usage'
              @property='memory_usage'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Strength'
              @property='strength'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Trash Cost'
              @property='trash_cost'
            />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Card Abilities</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @label='Has Additional Cost?'
              @property='additional_cost'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.additional_cost}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.additional_cost)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Advanceable?' @property='advanceable' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.advanceable}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.advanceable)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Gains Subroutines?'
              @property='gains_subroutines'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.gains_subroutines}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.gains_subroutines)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Has Interrupt?'
              @property='interrupt'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.interrupt}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.interrupt)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @label='On Encounter Effect?'
              @property='on_encounter_effect'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.on_encounter_effect}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.on_encounter_effect)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Performs Trace?'
              @property='performs_trace'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.performs_trace}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.performs_trace)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Rez Effect?' @property='rez_effect' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.rez_effect}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @triggerRole='listbox'
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.rez_effect)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Trash Ability?'
              @property='trash_ability'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.trash_ability}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.trash_ability)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Link Provided'
              @property='link_provided'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='MU Provided'
              @property='mu_provided'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Num Printed Subroutines'
              @property='num_printed_subroutines'
            />
          </div>
          <div class='col-sm-3'>
            <form.element
              @controlType='text'
              @label='Recurring Credits Provided'
              @property='recurring_credits_provided'
            />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Cycles & Sets</legend>
        <div class='row'>
          <div class='col-sm-6'>
            <form.element @label='Cycle' @property='card_cycle' as |el|>
              <PowerSelectMultiple
                @options={{@cardCycles}}
                @selected={{this.searchParams.card_cycle}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.card_cycle)}}
                as |x|
              >
                <Icon @icon={{x.id}} />
                {{x.name}}{{'         '}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-6'>
            <form.element @label='Set' @property='card_set' as |el|>
              <PowerSelectMultiple
                @options={{@cardSets}}
                @selected={{this.searchParams.card_set}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.card_set)}}
                as |x|
              >
                <Icon @icon={{x.cardCycleId}} />
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Formats, Card Pools, Restrictions, & Snapshots</legend>
        <div class='row'>
          <div class='col-sm-12'>
            <form.element @label='Snapshot' @property='snapshot' as |el|>
              <PowerSelectMultiple
                @options={{@snapshots}}
                @selected={{this.searchParams.snapshot}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.snapshot)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-4'>
            <form.element @label='Format' @property='format' as |el|>
              <PowerSelectMultiple
                @options={{@formats}}
                @selected={{this.searchParams.format}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.format)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element @label='Card Pool' @property='card_pool' as |el|>
              <PowerSelectMultiple
                @options={{@cardPools}}
                @selected={{this.searchParams.card_pool}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.card_pool)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element
              @label='Restriction List'
              @property='restriction_id'
              as |el|
            >
              <PowerSelectMultiple
                @options={{@restrictions}}
                @selected={{this.searchParams.restriction_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.restriction_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Designers and Publishers</legend>
        <div class='row'>
          <div class='col-sm-4'>
            <form.element @label='Designed By' @property='designed_by' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.orgs}}
                @selected={{this.searchParams.designed_by}}
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.designed_by)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element @label='Released By' @property='released_by' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.orgs}}
                @selected={{this.searchParams.released_by}}
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.released_by)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element
              @controlType='text'
              @label='Champion Card Designer'
              @property='attribution'
            />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Cycles & Sets</legend>
        <div class='row'>
          <div class='col-sm-6'>
          </div>
          <div class='col-sm-6'>
          </div>
        </div>
      </fieldset>

      <div class='row'>
        <div class='col-sm-3'>
          <form.element @label='Num Records' @property='max_records' as |el|>
            <PowerSelect
              @options={{this.numRecords}}
              @selected={{this.searchParams.max_records}}
              @triggerId={{el.id}}
              @onFocus={{action.focus}}
              @onChange={{fn (mut this.searchParams.max_records)}}
              as |x|
            >
              {{x}}
            </PowerSelect>
          </form.element>
        </div>
        <div class='col-sm-3'>
          <form.element @label='Display' @property='display' as |el|>
            <PowerSelect
              @options={{this.displayOptions}}
              @selected={{this.searchParams.display}}
              @triggerId={{el.id}}
              @onFocus={{action.focus}}
              @onChange={{fn (mut this.searchParams.display)}}
              as |x|
            >
              View as
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
        <div class='col-sm-2'>
          <form.submitButton>Submit</form.submitButton>
        </div>
      </div>
    </BsForm>
  </template>
}
