import Component from '@glimmer/component';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import Icon from '../icon';
import BsForm from 'ember-bootstrap/components/bs-form';
import PowerSelect from 'ember-power-select/components/power-select';

export default class SearchFormComponent extends Component {
  @service router;

  @tracked display = 'checklist';

  @tracked params = {
    max_records: 100,
  };

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

  @action doSearch(f) {
    // Only specify value for checkbox if explicitly set.
    f.latest_printing_only = f.latest_printing_only ? 't' : null;
    f.additional_cost = f.additional_cost ? 't' : null;
    f.advanceable = f.advanceable ? 't' : null;
    f.gains_subroutines = f.gains_subroutines ? 't' : null;
    f.interrupt = f.interrupt ? 't' : null;
    f.on_encounter_effect = f.on_encounter_effect ? 't' : null;
    f.performs_trace = f.performs_trace ? 't' : null;
    f.rez_effect = f.rez_effect ? 't' : null;
    f.trash_ability = f.trash_ability ? 't' : null;

    f.side_id = f.side_id ? f.side_id.id : null;
    f.faction_id = f.faction_id ? f.faction_id.id : null;
    f.card_type_id = f.card_type_id ? f.card_type_id.id : null;
    f.card_subtype_id = f.card_subtype_id ? f.card_subtype_id.id : null;
    f.illustrator_id = f.illustrator_id ? f.illustrator_id.id : null;
    f.num_printings = f.num_printings ? f.num_printings.id : null;
    f.is_unique = f.is_unique ? f.is_unique.id : null;
    f.quantity = f.quantity ? f.quantity.id : null;
    f.designed_by = f.designed_by ? f.designed_by.id : null;
    f.released_by = f.released_by ? f.released_by.id : null;

    f.has_additional_cost = f.has_additional_cost
      ? f.has_additional_cost.id
      : null;
    f.advanceable = f.advanceable ? f.advanceable.id : null;
    f.gains_subroutines = f.gains_subroutines ? f.gains_subroutines.id : null;
    f.has_interrupt = f.has_interrupt ? f.has_interrupt.id : null;
    f.on_encounter_effect = f.on_encounter_effect
      ? f.on_encounter_effect.id
      : null;
    f.performs_trace = f.performs_trace ? f.performs_trace.id : null;
    f.rez_effect = f.rez_effect ? f.rez_effect.id : null;
    f.trash_ability = f.trash_ability ? f.trash_ability.id : null;
    f.card_cycle = f.card_cycle ? f.card_cycle.id : null;
    f.card_set = f.card_set ? f.card_set.id : null;
    f.snapshot = f.snapshot ? f.snapshot.id : null;
    f.format_id = f.format_id ? f.format_id.id : null;
    f.card_pool_id = f.card_pool_id ? f.card_pool_id.id : null;
    f.restriction_id = f.restriction_id ? f.restriction_id.id : null;
    f.snapshot_id = f.snapshot_id ? f.snapshot_id.id : null;
    f.quantity = f.quantity ? f.quantity.id : null;
    f.query = null;

    this.router.transitionTo('page.advanced-search', {
      queryParams: f,
    });
  }

  <template>
    <h1>Search Form</h1>

    {{#if @searchParams.query}}
      <p>Free form query is: <strong>{{@searchParams.query}}</strong></p>
    {{/if}}

    {{!
== Result Type

# of records

[x] [checkbox] Latest Printing Only
[ ] [drop down] Sort by
  ^ Should also allow multiple.
  ^ Needs to ignore inline sorting in the card list component.

== Basic Card Attributes
[x] title, _: Type: string
[x] text, x: Type: string
[x] flavor, flavour, a: Type: string
[x] [drop down] side, d: Type: string
[-] [drop down] faction, f: Type: string << Should be multiple select
[-] [drop down] card_type, t: Type: string << Should be multiple select
[-] [drop down] card_subtype_id: Type: array << Should be multiple select
[x] [dropdown] is_unique, u: Type: boolean

=== Advanced Card Attributes
[x] [numeric] advancement_cost, g: Type: integer
[x] [numeric] agenda_points, v: Type: integer
[x] [numeric] cost, o: Type: integer
[x] [numeric] influence_cost, n: Type: integer

[x] [numeric] base_link, l: Type: integer
[x] [numeric] memory_usage, m: Type: integer
[x] [numeric] strength, p: Type: integer (X)
[x] [numeric] trash_cost, h: Type: integer

[x] [checkbox] additional_cost: Type: boolean
[x] [checkbox] advanceable: Type: boolean
[x] [checkbox] gains_subroutines: Type: boolean
[x] [checkbox] interrupt: Type: boolean
[x] [checkbox] on_encounter_effect: Type: boolean
[x] [checkbox] performs_trace: Type: boolean
[x] [checkbox] rez_effect: Type: boolean
[x] [checkbox] trash_ability: Type: boolean
[x] [numeric] link_provided: Type: integer
[x] [numeric] mu_provided: Type: integer  X
[x] [numeric] num_printed_subroutines: Type: integer
[x] [numeric] recurring_credits_provided: Type: integer X

== Attribution
[x] [dropdown] designed_by: Type: string
[x] [dropdown] released_by: Type: string
[x] attribution: Type: string
[x] [dropdown] card_cycle
[x] [dropdown] card_set
[x] [date] release_date, date_release, r: Type: date

== Flavor & Illustrators
[x] [multi-select] illustrator, i: Type: string

== Printings
[x] [numeric] num_printings: Type: integer
[x] [checkbox] is_latest_printing: Type: boolean

[x] [numeric] position: Type: integer
[x] [numeric] quantity, y: Type: integer

== Formats & Card Pools
[ ] [multi-select] format: Type: array << should be multi-select
[ ] [multi-select] card_pool, z: Type: array
[ ] [multi-select] snapshot: Type: array

== Restrictions
[multi-select] restriction_id, b: Type: array

[multi-select] eternal_points: Type: array
has_global_penalty: Type: array
[checkbox] is_banned: Type: array
[checkbox] is_restricted: Type: array
[checkbox] in_restriction: Type: boolean
universal_faction_cost: Type: array

}}

    <BsForm @formLayout="vertical" @onSubmit={{this.doSearch}} @model={{this.params}} as |form|>
      <fieldset>
        <legend>Title & Text</legend>
        <div class="row">
          <div class="col-sm-6">
            <form.element @controlType="text" @label="Title" @property="title" />
          </div>
          <div class="col-sm-6">
            <form.element @controlType="text" @label="Text" @property="text" />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Printing Attributes</legend>
        <div class="row">
          <div class="col-sm-3">
            <form.element @controlType="checkbox" @label="Latest Printing Only?" @property="latest_printing_only" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Position In Set" @property="position" />
          </div>
          <div class="col-sm-3">
            <form.element @label="Quantity In Set" @property="quantity" as |el|>
              <PowerSelect
                @options={{this.oneToSix}}
                @selected={{this.params.quantity}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.quantity)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Num Printings" @property="num_printings" as |el|>
              <PowerSelect
                @options={{this.oneToSix}}
                @selected={{this.params.num_printings}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.num_printings)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6">
            <form.element @controlType="text" @label="Flavor Text" @property="flavor" />
          </div>
          <div class="col-sm-6">
            <form.element @label="Illustrators" @property="max_records" as |el|>
              <PowerSelect
                @options={{@illustrators}}
                @selected={{this.params.illustrator_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.illustrator_id)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Card Attributes</legend>
        <div class="row">
          <div class="col-sm-3">
            <form.element @label="Side" @property="side_id" as |el|>
              <PowerSelect
                @options={{@sides}}
                @selected={{this.params.side_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.side_id)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Faction" @property="faction_id" as |el|>
              <PowerSelect
                @options={{@factions}}
                @selected={{this.params.faction_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.faction_id)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Card Type" @property="card_type_id" as |el|>
              <PowerSelect
                @options={{@cardTypes}}
                @selected={{this.params.card_type_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.card_type_id)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Card Subtype" @property="card_subtype_id" as |el|>
              <PowerSelect
                @options={{@cardSubtypes}}
                @selected={{this.params.card_subtype_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.card_subtype_id)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3">
            <form.element @label="Unique?" @property="is_unique" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.is_unique}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.is_unique)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Influence" @property="influence_cost" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Cost" @property="cost" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Advancement Requirement" @property="advancement_cost" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Agenda Points" @property="agenda_points" />
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Base Link" @property="base_link" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Memory Usage" @property="memory_usage" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Strength" @property="strength" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Trash Cost" @property="trash_cost" />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Card Abilities</legend>
        <div class="row">
          <div class="col-sm-3">
            <form.element @label="Has Additional Cost?" @property="additional_cost" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.additional_cost}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.additional_cost)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Advanceable?" @property="advanceable" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.advanceable}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.advanceable)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Gains Subroutines?" @property="gains_subroutines" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.gains_subroutines}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.gains_subroutines)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Has Interrupt?" @property="has_interrupt" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.has_interrupt}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.has_interrupt)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3">
            <form.element @label="On Encounter Effect?" @property="on_encounter_effect" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.on_encounter_effect}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.on_encounter_effect)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Performs Trace?" @property="performs_trace" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.performs_trace}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.performs_trace)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Rez Effect?" @property="rez_effect" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.rez_effect}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.rez_effect)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-3">
            <form.element @label="Trash Ability?" @property="trash_ability" as |el|>
              <PowerSelect
                @options={{this.isUnique}}
                @selected={{this.params.trash_ability}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.trash_ability)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Link Provided" @property="link_provided" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="MU Provided" @property="mu_provided" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Num Printed Subroutines" @property="num_printed_subroutines" />
          </div>
          <div class="col-sm-3">
            <form.element @controlType="text" @label="Recurring Credits Provided" @property="recurring_credits_provided" />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Cycles & Sets</legend>
        <div class="row">
          <div class="col-sm-6">
            <form.element @label="Cycle" @property="card_cycle" as |el|>
              <PowerSelect
                @options={{@cardCycles}}
                @selected={{this.params.card_cycle}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.card_cycle)}} as |x|>
                <Icon @icon={{x.id}} /> {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-6">
            <form.element @label="Set" @property="card_set" as |el|>
              <PowerSelect
                @options={{@cardSets}}
                @selected={{this.params.card_set}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.card_set)}} as |x|>
                <Icon @icon={{x.cardCycleId}} /> {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Formats, Card Pools, Restrictions, & Snapshots</legend>
        <div class="row">
          <div class="col-sm-12">
            <form.element @label="Snapshot" @property="snapshot" as |el|>
              <PowerSelect
                @options={{@snapshots}}
                @selected={{this.params.snapshot}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.snapshot)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-4">
            <form.element @label="Format" @property="format" as |el|>
              <PowerSelect
                @options={{@formats}}
                @selected={{this.params.format}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.format)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-4">
            <form.element @label="Card Pool" @property="card_pool" as |el|>
              <PowerSelect
                @options={{@cardPools}}
                @selected={{this.params.card_pool}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.card_pool)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-4">
            <form.element @label="Restriction List" @property="restriction_id" as |el|>
              <PowerSelect
                @options={{@restrictions}}
                @selected={{this.params.restriction_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.restriction_id)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Designers and Publishers</legend>
        <div class="row">
          <div class="col-sm-4">
            <form.element @label="Designed By" @property="designed_by" as |el|>
              <PowerSelect
                @options={{this.orgs}}
                @selected={{this.params.designed_by}}
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.designed_by)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-4">
            <form.element @label="Released By" @property="released_by" as |el|>
              <PowerSelect
                @options={{this.orgs}}
                @selected={{this.params.released_by}}
                @triggerId={{el.id}}
                @onFocus={{action.focus}}
                @onChange={{fn (mut this.params.released_by)}} as |x|>
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class="col-sm-4">
            <form.element @controlType="text" @label="Champion Card Designer" @property="attribution" />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Cycles & Sets</legend>
        <div class="row">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
          </div>
        </div>
      </fieldset>

      <div class="row">
        <div class="col-sm-3">
          <form.element @label="Num Records" @property="max_records" as |el|>
            <PowerSelect
              @options={{this.numRecords}}
              @selected={{this.params.max_records}}
              @triggerId={{el.id}}
              @onFocus={{action.focus}}
              @onChange={{fn (mut this.params.max_records)}} as |x|>
              {{x}}
            </PowerSelect>
          </form.element>
        </div>
        <div class="col-sm-3">
          <form.element @label="Display" @property="display" as |el|>
            <PowerSelect
              @options={{this.displayOptions}}
              @selected={{this.display}}
              @triggerId={{el.id}}
              @onFocus={{action.focus}}
              @onChange={{fn (mut this.display)}} as |x|>
              View as {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
        <div class="col-sm-2">
          <form.submitButton>Submit</form.submitButton>
        </div>
      </div>
    </BsForm>

  </template>
}
