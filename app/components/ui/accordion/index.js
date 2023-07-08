import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked as trackedBuiltin } from 'tracked-built-ins';
import { tracked } from '@glimmer/tracking';

export default class PanelListComponent extends Component {
  panels = trackedBuiltin([]);
  @tracked query = '';

  constructor() {
    super(...arguments);

    this.panels.push(!!this.args.expandFirstItem);
    this.args.items.slice(1).forEach(() => this.panels.push(false));
  }

  @action setAllPanels(value) {
    for (let i in this.panels) {
      this.panels[i] = value;
    }
  }

  @action togglePanel(panel) {
    this.panels[panel] = !this.panels[panel];
  }

  isPanelFiltered(query, property) {
    if (query.length === 0) {
      return false;
    }

    return !property.toLowerCase().includes(query);
  }
}
