import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import { eq } from '../../utils/template-operators';
import selectOption from '../../modifiers/select-option';

export default class SearchFormComponent extends Component {
  @service router;

  @action doSearch(e) {
    e.preventDefault();

    const form = new FormData(e.target);
    const searchParams = Object.fromEntries(form.entries());
    searchParams.latest_printing_only = !!searchParams.latest_printing_only;
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
[numeric] agenda_points, v: Type: integer
[numeric] cost, o: Type: integer
[numeric] influence_cost, n: Type: integer
[numeric] advancement_cost, g: Type: integer
[numeric] base_link, l: Type: integer
[numeric] memory_usage, m: Type: integer
[numeric] strength, p: Type: integer
[numeric] trash_cost, h: Type: integer
[checkbox] additional_cost: Type: boolean
[checkbox] advanceable: Type: boolean
[checkbox] gains_subroutines: Type: boolean
[checkbox] interrupt: Type: boolean
[checkbox] on_encounter_effect: Type: boolean
[checkbox] performs_trace: Type: boolean
[checkbox] rez_effect: Type: boolean
[checkbox] trash_ability: Type: boolean
[numeric] link_provided: Type: integer
[numeric] mu_provided: Type: integer
[numeric] num_printed_subroutines: Type: integer
[numeric] recurring_credits_provided: Type: integer

== Attribution
[x] [dropdown] designed_by: Type: string
[x] [dropdown] released_by: Type: string

[ ] [date] release_date, date_release, r: Type: date

[x] attribution: Type: string

== Flavor & Illustrators
[x] [multi-select] illustrator, i: Type: string

== Printings
[x] [numeric] num_printings: Type: integer
[x] [checkbox] is_latest_printing: Type: boolean

[ ] [numeric] position: Type: integer
[ ] [numeric] quantity, y: Type: integer

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
        <p>
          <label for='max_records'>Max Records</label>
          <select
            id='max_records'
            name='max_records'
            {{selectOption @searchParams.max_records}}
          >
            <option value='100'>100</option>
            <option value='250'>250</option>
            <option value='500'>500</option>
            <option value='1000'>1000</option>
          </select>
        </p>
        <p>
          <label for='latest_printing_only'>Latest Printing Only</label>
          <input
            id='latest_printing_only'
            name='latest_printing_only'
            type='checkbox'
            checked={{eq @searchParams.latest_printing_only 'true'}}
            value={{eq @searchParams.latest_printing_only 'true'}}
          />
        </p>
        <p>
          <label for='num_printings'>Num Printings for Card</label>
          <select
            id='num_printings'
            name='num_printings'
            {{selectOption @searchParams.num_printings}}
          >
            <option value=''>Any</option>
            <option value='1'>1</option>
            <option value='2'>2</option>
            <option value='3'>3</option>
            <option value='4'>4</option>
            <option value='5'>5</option>
            <option value='6'>6</option>
          </select>
        </p>
        <p>
          <label for='title'>Title:</label>
          <input
            type='text'
            id='title'
            name='title'
            value='{{@searchParams.title}}'
          />
        </p>
        <p>
          <label for='text'>Text:</label>
          <input
            type='text'
            id='text'
            name='text'
            value='{{@searchParams.text}}'
          />
        </p>
        <p>
          <label for='flavor'>Flavor:</label>
          <input
            type='text'
            id='flavor'
            name='flavor'
            value='{{@searchParams.flavor}}'
          />
        </p>
        <p>
          <label for='side_id'>Side</label>
          <select
            id='side_id'
            name='side_id'
            {{selectOption @searchParams.side_id}}
          >
            <option value=''>Either</option>
            {{#each @sides as |side|}}
              <option value='{{side.id}}'>{{side.name}}</option>
            {{/each}}
          </select>
        </p>
        <p>
          <label for='faction_id'>Faction</label>
          <select
            id='faction_id'
            name='faction_id'
            {{selectOption @searchParams.faction_id}}
          >
            <option value=''>Any</option>
            {{#each @factions as |faction|}}
              <option value='{{faction.id}}'>{{faction.name}}</option>
            {{/each}}
          </select>
        </p>
        <p>
          <label for='card_type_id'>Card Type</label>
          <select
            id='card_type_id'
            name='card_type_id'
            {{selectOption @searchParams.card_type_id}}
          >
            <option value=''>Any</option>
            {{#each @cardTypes as |card_type|}}
              <option value='{{card_type.id}}'>{{card_type.name}}</option>
            {{/each}}
          </select>
        </p>
        <p>
          <label for='card_subtype_id'>Card Subtype</label>
          <select
            id='card_subtype_id'
            name='card_subtype_id'
            {{selectOption @searchParams.card_subtype_id}}
          >
            <option value=''>Any</option>
            {{#each @cardSubtypes as |card_subtype|}}
              <option value='{{card_subtype.id}}'>{{card_subtype.name}}</option>
            {{/each}}
          </select>
        </p>
        <p>
          <label for='is_unique'>Unique?</label>
          <select
            id='is_unique'
            name='is_unique'
            {{selectOption @searchParams.is_unique}}
          >
            <option value=''>Either</option>
            <option value='t'>Yes</option>
            <option value='f'>No</option>
          </select>
        </p>
        <p>
          <label for='designed_by'>Designed By Org</label>
          <select
            id='designed_by'
            name='designed_by'
            {{selectOption @searchParams.designed_by}}
          >
            <option value=''>Either</option>
            <option value='null_signal_games'>Null Signal Games</option>
            <option value='fantasy_flight_games'>Fantasy Flight Games</option>
          </select>
        </p>
        <p>
          <label for='released_by'>Released By Org</label>
          <select
            id='released_by'
            name='released_by'
            {{selectOption @searchParams.released_by}}
          >
            <option value=''>Either</option>
            <option value='null_signal_games'>Null Signal Games</option>
            <option value='fantasy_flight_games'>Fantasy Flight Games</option>
          </select>
        </p>
        <p>
          <label for='attribution'>Individual Card Designer:</label>
          <input
            type='text'
            id='attribution'
            name='attribution'
            value='{{@searchParams.attribution}}'
          />
        </p>
        <p>
          <label for='illustrator_id'>Illustrator</label>
          <select
            id='illustrator_id'
            name='illustrator_id'
            {{selectOption @searchParams.illustrator_id}}
          >
            <option value=''>Any</option>
            {{#each @illustrators as |illustrator|}}
              <option value='{{illustrator.id}}'>{{illustrator.name}}</option>
            {{/each}}
          </select>
        </p>
        <p>
          <input type='submit' aria-label='Search' />
        </p>
      </form>
    </div>
  </template>
}
