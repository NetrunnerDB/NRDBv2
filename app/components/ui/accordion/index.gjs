import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked as trackedBuiltin } from 'tracked-built-ins';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { fn, get } from '@ember/helper';
import { on } from '@ember/modifier';
import { sortBy } from '@nullvoxpopuli/ember-composable-helpers';
import { or } from 'ember-truth-helpers';

import Panel from 'netrunnerdb/components/ui/accordion/panel';

export default class AccordionComponent extends Component {
  @service router;

  panels = trackedBuiltin([]);
  @tracked isDropdownOpen = false;
  @tracked sortBy = 'dateStart:desc';

  constructor() {
    super(...arguments);

    this.panels.push(...new Array(this.args.items.length).fill(false));
    this.panels[0] = !!this.args.expandFirstItem;
  }

  get query() {
    return this.args.query ?? '';
  }

  @action setAllPanels(value) {
    this.panels.fill(value);
  }

  @action togglePanel(panel) {
    this.panels[panel] = !this.panels[panel];
  }

  isPanelFiltered(query, property) {
    if (query.length === 0) {
      return false;
    }

    return !property.toLowerCase().includes(query.toLowerCase());
  }

  @action updateFilter({ target: { value: search } }) {
    this.router.transitionTo({ queryParams: { search } });
  }

  @action toggleDropdown() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  @action setSortingOrder(order, event) {
    event.preventDefault();
    this.sortBy = order;
    this.isDropdownOpen = false;
  }

  <template>
    {{#if true}}
      <div class='panel-list'>
        {{#if (or @showMassToggle @showSearch @showSort)}}
          <p class='row'>
            {{#if @showMassToggle}}
              <button
                class='show-all col-2 btn btn-secondary'
                type='button'
                {{on 'click' (fn this.setAllPanels true)}}
              >Show all</button>
            {{/if}}
            {{#if @showSearch}}
              <div class='panel-search'>
                <input
                  type='text'
                  class='form-control'
                  placeholder='Search...'
                  aria-label='Search'
                  value={{this.query}}
                  {{on 'input' this.updateFilter}}
                />
              </div>
            {{/if}}
            {{#if @showMassToggle}}
              <button
                class='hide-all col-2 btn btn-secondary'
                type='button'
                {{on 'click' (fn this.setAllPanels false)}}
              >Hide all</button>
            {{/if}}
            {{#if @showSort}}
              <div
                class='panel-dropdown dropdown
                  {{if this.isDropdownOpen "open"}}'
              >
                <button
                  class='dropdown-toggle btn btn-light'
                  data-toggle='dropdown'
                  aria-expanded='{{this.isDropdownOpen}}'
                  type='button'
                  {{on 'click' this.toggleDropdown}}
                >
                  Sort
                  <span class='caret'></span>
                </button>
                <ul class='dropdown-menu dropdown-menu-right' role='menu'>
                  <li><a
                      href='#'
                      id='sort-0'
                      {{on 'click' (fn this.setSortingOrder 'name:asc')}}
                    >Name (A-Z)</a></li>
                  <li><a
                      href='#'
                      id='sort-1'
                      {{on 'click' (fn this.setSortingOrder 'name:desc')}}
                    >Name (Z-A)</a></li>
                  <li><a
                      href='#'
                      id='sort-2'
                      {{on
                        'click'
                        (fn this.setSortingOrder 'numPrintings:desc')
                      }}
                    >Cards (most)</a></li>
                  <li><a
                      href='#'
                      id='sort-3'
                      {{on
                        'click'
                        (fn this.setSortingOrder 'numPrintings:asc')
                      }}
                    >Cards (least)</a></li>
                </ul>
              </div>
            {{/if}}
          </p>
        {{/if}}
        {{#each (sortBy this.sortBy @items) as |item index|}}
          {{yield
            (component
              Panel
              query=this.query
              isOpen=(get this.panels index)
              isFiltered=(this.isPanelFiltered this.query item.name)
              togglePanel=(fn this.togglePanel index)
            )
            item
          }}
        {{/each}}
      </div>
    {{else}}
      {{yield to='empty'}}
    {{/if}}
  </template>
}
