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
[ ] [drop down] View As

== Basic Card Attributes
[x] title, _: Type: string
[x] text, x: Type: string

[x] [drop down] side, d: Type: string

[-] [drop down] faction, f: Type: string
[drop down] faction_id of this card.
^^ Should be multiple select

[-] [drop down] card_type, t: Type: string
^^ Should be multiple select

[drop down] card_subtype, s: Type: array
[drop down] text names for card subtypes, matched as lowercase.

[drop down] card_subtype_id: Type: array
[drop down] card_subtype_ids for the card.

[numeric] agenda_points, v: Type: integer
The printed number of agenda points for the agenda.

[numeric] cost, o: Type: integer
The printed cost of a card. Accepts positive integers and X (case-insensitive).

[numeric] influence_cost, n: Type: integer
The influence cost or number of influence pips for the card.

[checkbox] is_unique, u: Type: boolean
Is the card unique?

[numeric] advancement_cost, g: Type: integer
The advancement_cost value for an agenda. Accepts positive integers and X (case-insensitive).

[numeric] base_link, l: Type: integer
The printed link value for an Identity.

[numeric] memory_usage, m: Type: integer
The memory (MU) cost of this card.

[numeric] strength, p: Type: integer
The strength of the card. Accepts integers or X.

[numeric] trash_cost, h: Type: integer
The trash cost of this card.

== Advanced Card Attributes
[checkbox] additional_cost: Type: boolean
Does the card text specify an additional cost to play?

[checkbox] advanceable: Type: boolean
Is the card advanceable?

[checkbox] gains_subroutines: Type: boolean
Does the card text allow for adding or gaining subroutines?

[checkbox] interrupt: Type: boolean
Does the card have an interrupt ability?

[checkbox] on_encounter_effect: Type: boolean
Does the card text specify an on encounter effect?

[checkbox] performs_trace: Type: boolean
Does the card perform a trace?

[checkbox] rez_effect: Type: boolean
Does the card have a rez effect?

[checkbox] trash_ability: Type: boolean
Does the card provide a trash ability?

[numeric] link_provided: Type: integer
The amount of link provided.

[numeric] mu_provided: Type: integer
The amount of memory (MU) provided by the card.

[numeric] num_printed_subroutines: Type: integer
The number of printed subroutines on this card.

[numeric] recurring_credits_provided: Type: integer
The number of recurring credits provided by this card. Accepts integers or X.

== Attribution
designed_by: Type: string
The organization that designed the card.

[multi-select] released_by: Type: string
The organization that released the printing.

[multi-select] printings_released_by: Type: array
All organizations that have released printings for a card.

[date] release_date, date_release, r: Type: date
The earliest release date for a card or the release date for the set for a printing.

attribution: Type: string
The designer of this card text, if specified.

== Flavor & Illustrators
flavor, flavour, a: Type: string
The flavor text for a printing.

[multi-select] illustrator, i: Type: string
The printed version of the illustrator credits, with multiple illustrators separated by commas.

illustrator_id: Type: array
illustrator_id for an illustrator for the printing.

== Printings
[numeric] num_printings: Type: integer
Count of unique printings for this card.

[x] [checkbox] is_latest_printing: Type: boolean
Is this printing the latest printing for a card?

[numeric] position: Type: integer
The position of the printing in a card set.

[numeric] quantity, y: Type: integer
The number of copies of a printing in the set.

== Formats & Card Pools
[multi-select] format: Type: array
format_id for any format containing the card at any time.

[multi-select] card_pool, z: Type: array
card_pool_ids for a card pool containing a card.

[multi-select] snapshot: Type: array
snapshot_id of a snapshot containing a card.

== Restrictions
[multi-select] restriction_id, b: Type: array
restriction_id specifying the card for any reason, like: restriction_id:eternal_points_list_22_09

[multi-select] eternal_points: Type: array
Concatenation of restriction_id and an Eternal Points value, joined by a hyphen, like eternal_points:eternal_points_list_22_09-2.

has_global_penalty: Type: array
restriction_id restricting the card with a global penalty, like has_global_penalty:napd_mwl_1_1.

[checkbox] is_banned: Type: array
restriction_id specifying the card as banned, like is_banned:standard_ban_list_22_08.

[checkbox] is_restricted: Type: array
restriction_id specifying the card as banned, like is_restricted:standard_mwl_3_4_b.

[checkbox] in_restriction: Type: boolean
Is the card specified on any Restriction list?

universal_faction_cost: Type: array
Concatenation of restriction_id and a Universal Faction Cost value, joined by a hyphen, like universal_faction_cost:napd_mwl_1_2-3.
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
            <option value='25'>25</option>
            <option value='50'>50</option>
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
            <option value=''></option>
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
            <option value=''></option>
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
            <option value=''></option>
            {{#each @cardTypes as |card_type|}}
              <option value='{{card_type.id}}'>{{card_type.name}}</option>
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
