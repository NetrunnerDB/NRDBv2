import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import CheckboxElement from './checkbox-element';
import NumericElement from './numeric-element';
import SelectElement from './select-element';
import StringTextElement from './string-text-element';

export default class SearchFormComponent extends Component {
  @service router;

  @action doSearch(e) {
    e.preventDefault();

    const form = new FormData(e.target);
    const searchParams = Object.fromEntries(form.entries());
    // Only specify value for checkbox if explicitly set.
    searchParams.latest_printing_only = searchParams.latest_printing_only
      ? 't'
      : null;
    searchParams.additional_cost = searchParams.additional_cost ? 't' : null;
    searchParams.advanceable = searchParams.advanceable ? 't' : null;
    searchParams.gains_subroutines = searchParams.gains_subroutines
      ? 't'
      : null;
    searchParams.interrupt = searchParams.interrupt ? 't' : null;
    searchParams.on_encounter_effect = searchParams.on_encounter_effect
      ? 't'
      : null;
    searchParams.performs_trace = searchParams.performs_trace ? 't' : null;
    searchParams.rez_effect = searchParams.rez_effect ? 't' : null;
    searchParams.trash_ability = searchParams.trash_ability ? 't' : null;

    searchParams.query = null;

    this.router.transitionTo('page.advanced-search', {
      queryParams: searchParams,
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
[ ] [dropdown] card_cycle
[ ] [dropdown] card_set
[ ] [date] release_date, date_release, r: Type: date

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

    <div>
      <form id='advanced-search' {{on 'submit' this.doSearch}}>
        <h2>Title & Text</h2>
        <p>
          <StringTextElement @name='Title' @id='title' @value='{{@searchParams.title}}' />
          <StringTextElement @name='Card Text' @id='text' @value='{{@searchParams.text}}' />
        </p>
        <h2>Printing Attributes</h2>
        <p>
          <CheckboxElement @name='Latest Printing Only' @id='latest_printing_only' @value='{{@searchParams.latest_printing_only}}' />
          <NumericElement @min={{0}} @name='Position In Set' @id='position' @value='{{@searchParams.position}}' />
          <NumericElement @min={{0}} @name='Quantity' @id='quantity' @value='{{@searchParams.quantity}}' />
          <SelectElement @id='num_printings' @name='Num Printings for Card' @options={{@numPrintings}} @value={{@searchParams.num_printings}} />
        </p>
        <h2>Card Attributes</h2>
        <p>
          <SelectElement @emptyDefault='Any' @id='side_id' @name='Side' @options={{@sides}} @value={{@searchParams.side_id}} />
          <SelectElement @emptyDefault='Any' @id='faction_id' @name='Faction' @options={{@factions}} @value={{@searchParams.faction_id}} />
          <SelectElement @emptyDefault='Any' @id='card_type_id' @name='Card Type' @options={{@cardTypes}} @value={{@searchParams.card_type_id}} />
          <SelectElement @emptyDefault='Any' @id='card_subtype_id' @name='Card Subtype' @options={{@cardSubtypes}} @value={{@searchParams.card_subtype_id}} />
        </p>
        <p>
          <SelectElement @emptyDefault='Any' @id='is_unique' @name='Unique?' @options={{@isUnique}} @value={{@searchParams.is_unique}} />
        </p>

        <div>
          <h3>Card Attributes</h3>
          <p>
            <NumericElement @name='Influence'
                @id='influence_cost' min={{0}} max={{5}} @value='{{@searchParams.influence_cost}}' />
            <NumericElement @name='Cost'
                @id='cost' min={{-1}} max={{6}} @value='{{@searchParams.agenda_points}}' />
          </p>
          <p>
            <NumericElement @name='Advancement Requirement'
                @id='advancement_cost' min={{-1}} max={{9}} @value='{{@searchParams.advancement_cost}}' />
            <NumericElement @name='Agenda Points'
                @id='agenda_points' min={{0}} max={{6}} @value='{{@searchParams.agenda_points}}' />
          </p>
          <p>
            <NumericElement @name='Base Link'
                @id='base_link' min={{0}} max={{2}} @value='{{@searchParams.base_link}}' />
            <NumericElement @name='Memory Usage'
                @id='memory_usage' min={{0}} max={{4}} @value='{{@searchParams.memory_usage}}' />
          </p>
          <p>
            <NumericElement @name='Strength'
                @id='strength' min={{-1}} max={{11}} @value='{{@searchParams.strength}}' />
            <NumericElement @name='Trash Cost'
                @id='trash_cost' min={{0}} max={{8}} @value='{{@searchParams.trash_cost}}' />
          </p>
        </div>
        <div>
          <h3>Card Abilities</h3>
          <p>
           <CheckboxElement @name='Has Additional Cost?'
               @id='additional_cost' @value='{{@searchParams.additional_cost}}' />
           <CheckboxElement @name='Advanceable?'
               @id='advanceable' @value='{{@searchParams.advanceable}}' />
           <CheckboxElement @name='Gains Subroutines?'
               @id='gains_subroutines' @value='{{@searchParams.gains_subroutines}}' />
          </p>
          <p>
            <CheckboxElement @name='Has Interrupt?'
                @id='interrupt' @value='{{@searchParams.interrupt}}' />
            <CheckboxElement @name='On Encounter Effect?'
                @id='on_encounter_effect' @value='{{@searchParams.on_encounter_effect}}' />
            <CheckboxElement @name='Performs Trace?'
                @id='performs_trace' @value='{{@searchParams.performs_trace}}' />
          </p>
          <p>
            <CheckboxElement @name='Rez Effect?'
                @id='rez_effect' @value='{{@searchParams.rez_effect}}' />
            <CheckboxElement @name='Trash Ability?'
                @id='trash_ability' @value='{{@searchParams.trash_ability}}' />
          </p>
          <p>
            <NumericElement @name='Link Provided'
                @id='link_provided' min={{0}} max={{2}} @value='{{@searchParams.link_provided}}' />
            <NumericElement @name='MU Provided'
                @id='mu_provided' min={{-1}} max={{3}} @value='{{@searchParams.mu_provided}}' />
          </p>
          <p>
            <NumericElement @name='Num Printed Subroutines'
                @id='num_printed_subroutines' min={{0}} max={{11}} @value='{{@searchParams.num_printed_subroutines}}' />
            <NumericElement @name='Recurring Credits Provided'
                @id='recurring_credits_provided' min={{-1}} max={{8}} @value='{{@searchParams.recurring_credits_provided}}' />
          </p>
        </div>

        <h2>Designers and Publishers</h2>
        <p>
          <SelectElement @emptyDefault='Any' @id='designed_by' @name='Designed By Org' @options={{@orgs}} @value={{@searchParams.designed_by}} />
        </p>
        <p>
          <SelectElement @emptyDefault='Any' @id='released_by' @name='Released By Org' @options={{@orgs}} @value={{@searchParams.released_by}} />
        </p>
        <p>
          <StringTextElement @name='Champion Card Designer' @id='attribution' @value='{{@searchParams.attribution}}' />
        </p>
        <h2>Flavor & Illustrators</h2>
        <p>
          <StringTextElement @name='Flavor Text' @id='flavor' @value='{{@searchParams.flavor}}' />
        </p>
        <p>
          <SelectElement @emptyDefault='Any' @id='illustrator_id' @name='Illustrator' @options={{@illustrators}} @value={{@searchParams.illustrator_id}} />
        </p>
        <p>
          <SelectElement @id='max_records' @name='MaxRecords' @options={{@numRecords}} @value={{@searchParams.max_records}} />
          <input type='submit' aria-label='Search' />
        </p>
      </form>
    </div>
  </template>
}
