import Component from '@glimmer/component';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import BsForm from 'ember-bootstrap/components/bs-form';
import PowerSelect from 'ember-power-select/components/power-select';

export default class SearchFormComponent extends Component {
  @service router;

  @tracked params = {
    max_records: 100,
  };

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
          Flavor Text
          </div>
          <div class="col-sm-3">
          Illustrators
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>Card Attributes</legend>
        <div class="row">
          <div class="col-sm-3">
          </div>
          <div class="col-sm-3">
          </div>
          <div class="col-sm-3">
          </div>
          <div class="col-sm-3">
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>Card Abilities</legend>
        <div class="row">
          <div class="col-sm-3">
          </div>
          <div class="col-sm-3">
          </div>
          <div class="col-sm-3">
          </div>
          <div class="col-sm-3">
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
      <fieldset>
        <legend>Formats, Card Pools, Restrictions, & Snapshots</legend>
        <div class="row">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>Deckbuilding Restrictions</legend>
        <div class="row">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>Designers and Publishers</legend>
        <div class="row">
          <div class="col-sm-6">
          </div>
          <div class="col-sm-6">
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
          Max Records Goes Here.
        </div>
        <div class="col-sm-2">
          <form.submitButton>Submit</form.submitButton>
        </div>
      </div>
    </BsForm>

  </template>
}
