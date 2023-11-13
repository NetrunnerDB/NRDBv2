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

  constructor() {
    super(...arguments);
    this.searchParams = this.args.searchParams;
  }

  displayOptions = [
    { id: 'checklist', name: 'Checklist' },
    { id: 'full', name: 'Full Card' },
    { id: 'images', name: 'Image Only' },
    { id: 'text', name: 'Text Only' },
  ];
  isUnique = [
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

    if (p.title && p.title.trim().length == 0) {
      p.title = null;
    }
    if (p.text && p.text.trim().length == 0) {
      p.text = null;
    }

    // Only specify value for checkbox if explicitly set.
    p.latest_printing_only = p.latest_printing_only ? 't' : null;
    p.additional_cost = p.additional_cost ? 't' : null;
    p.advanceable = p.advanceable ? 't' : null;
    p.gains_subroutines = p.gains_subroutines ? 't' : null;
    p.interrupt = p.interrupt ? 't' : null;
    p.on_encounter_effect = p.on_encounter_effect ? 't' : null;
    p.performs_trace = p.performs_trace ? 't' : null;
    p.rez_effect = p.rez_effect ? 't' : null;
    p.trash_ability = p.trash_ability ? 't' : null;

    p.side_id = p.side_id ? p.side_id.id : null;
    if (p.faction_id) {
      if (p.faction_id.length != 0) {
        p.faction_id = p.faction_id.map((x) => x.id);
      } else {
        p.faction_id = null;
      }
    }
    if (p.card_type_id) {
      if (p.card_type_id.length != 0) {
        p.card_type_id = p.card_type_id.map((x) => x.id);
      } else {
        p.card_type_id = null;
      }
    }
    if (p.card_subtype_id) {
      if (p.card_subtype_id.length != 0) {
        p.card_subtype_id = p.card_subtype_id.map((x) => x.id);
      } else {
        p.card_subtype_id = null;
      }
    }
    if (p.illustrator_id) {
      if (p.illustrator_id.length != 0) {
        p.illustrator_id = p.illustrator_id.map((x) => x.id);
      } else {
        p.illustrator_id = null;
      }
    }

    p.num_printings = p.num_printings ? p.num_printings.id : null;
    p.is_unique = p.is_unique ? p.is_unique.id : null;
    p.quantity = p.quantity ? p.quantity.id : null;
    p.designed_by = p.designed_by ? p.designed_by.id : null;
    p.released_by = p.released_by ? p.released_by.id : null;

    p.has_additional_cost = p.has_additional_cost
      ? p.has_additional_cost.id
      : null;
    p.advanceable = p.advanceable ? p.advanceable.id : null;
    p.gains_subroutines = p.gains_subroutines ? p.gains_subroutines.id : null;
    p.has_interrupt = p.has_interrupt ? p.has_interrupt.id : null;
    p.on_encounter_effect = p.on_encounter_effect
      ? p.on_encounter_effect.id
      : null;
    p.performs_trace = p.performs_trace ? p.performs_trace.id : null;
    p.rez_effect = p.rez_effect ? p.rez_effect.id : null;
    p.trash_ability = p.trash_ability ? p.trash_ability.id : null;

    if (p.card_cycle) {
      if (p.card_cycle.length != 0) {
        p.card_cycle = p.card_cycle.map((x) => x.id);
      } else {
        p.card_cycle = null;
      }
    }
    if (p.card_set) {
      if (p.card_set.length != 0) {
        p.card_set = p.card_set.map((x) => x.id);
      } else {
        p.card_set = null;
      }
    }

    p.snapshot = p.snapshot ? p.snapshot.id : null;
    p.format_id = p.format_id ? p.format_id.id : null;
    p.card_pool_id = p.card_pool_id ? p.card_pool_id.id : null;
    p.restriction_id = p.restriction_id ? p.restriction_id.id : null;
    p.snapshot_id = p.snapshot_id ? p.snapshot_id.id : null;

    this.router.transitionTo(this.router.currentRouteName, {
      queryParams: p,
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
            <form.element
              @controlType='checkbox'
              @label='Latest Printing Only?'
              @property='latest_printing_only'
            />
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
            <form.element @label='Illustrators' @property='max_records' as |el|>
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
                @options={{this.isUnique}}
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
                @options={{this.isUnique}}
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
                @options={{this.isUnique}}
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
                @options={{this.isUnique}}
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
              @property='has_interrupt'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.isUnique}}
                @selected={{this.searchParams.has_interrupt}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.searchParams.has_interrupt)}}
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
                @options={{this.isUnique}}
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
                @options={{this.isUnique}}
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
                @options={{this.isUnique}}
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
                @options={{this.isUnique}}
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
              @onChange={{fn (mut this.display)}}
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
