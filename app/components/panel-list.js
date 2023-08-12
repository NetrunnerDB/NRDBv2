import Component from '@glimmer/component';
import { action } from '@ember/object';
import { sendEvent } from '@ember/object/events';
import { getOwner } from '@ember/application';
import { tracked as trackedBuiltin } from 'tracked-built-ins';
import { tracked } from '@glimmer/tracking';

export default class PanelListComponent extends Component {
  query = '';
  panels = trackedBuiltin([]);
  @tracked isDropdownOpen = false;
  @tracked sortBy = 'dateStart:desc';

  constructor() {
    super(...arguments);
    this.args.items.forEach(() => this.panels.push(false));
  }

  @action showAll() {
    for (let i in this.panels) {
      this.panels[i] = true;
    }
  }

  @action hideAll() {
    for (let i in this.panels) {
      this.panels[i] = false;
    }
  }

  @action filter() {
    sendEvent(getOwner(this), 'filter', [this.query.toLowerCase()]);
  }

  @action showPanel(panel) {
    this.panels[panel] = true;
  }

  @action hidePanel(panel) {
    this.panels[panel] = false;
  }

  @action toggleDropdown() {
    this.isDropdownOpen = !this.isDropdownOpen;
  }

  @action setSortingOrder(order, event) {
    event.preventDefault();
    this.sortBy = order;
    this.isDropdownOpen = false;
  }
}
